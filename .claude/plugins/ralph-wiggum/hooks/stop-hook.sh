#!/bin/bash
set -e

# Ralph Wiggum Stop Hook
# This hook implements the self-referential loop by sending input to Claude
# when a session ends, causing it to restart automatically.

STATE_FILE="$CLAUDE_PROJECT_DIR/.claude/ralph-state.json"
SCRIPTS_DIR="$CLAUDE_PROJECT_DIR/.claude/plugins/ralph-wiggum/scripts"

# Source utilities
source "$SCRIPTS_DIR/ralph-utils.sh"

# Check if state file exists
if [[ ! -f "$STATE_FILE" ]]; then
    exit 0
fi

# Read state
state=$(cat "$STATE_FILE")
active=$(echo "$state" | jq -r '.active // false')

# Exit if loop is not active
if [[ "$active" != "true" ]]; then
    exit 0
fi

# Read loop parameters
iteration=$(echo "$state" | jq -r '.iteration // 0')
max_iterations=$(echo "$state" | jq -r '.maxIterations // 50')
task_description=$(echo "$state" | jq -r '.taskDescription // ""')
completion_promise=$(echo "$state" | jq -r '.completionPromise // "COMPLETE"')
start_time=$(echo "$state" | jq -r '.startTime // ""')
timeout_minutes=$(echo "$state" | jq -r '.timeoutMinutes // 240')
persist_context=$(echo "$state" | jq -r '.persistContext // false')
quality_gates=$(echo "$state" | jq -r '.qualityGates // false')
task_dir=$(echo "$state" | jq -r '.taskDir // ""')
last_error=$(echo "$state" | jq -r '.lastError // ""')

# --- SAFETY CHECK 1: Max Iterations ---
if [[ $iteration -ge $max_iterations ]]; then
    echo "⛔ Ralph loop reached max iterations ($max_iterations). Exiting."
    update_state_field "active" "false"
    update_state_field "exitReason" "max_iterations"
    if [[ "$persist_context" == "true" ]] && [[ -n "$task_dir" ]]; then
        update_context_file "$task_dir" "Exited: Max iterations ($max_iterations) reached"
    fi
    exit 0
fi

# --- SAFETY CHECK 2: Runtime Limit ---
if [[ -n "$start_time" ]]; then
    elapsed_minutes=$(get_elapsed_minutes "$start_time")
    if [[ $elapsed_minutes -ge $timeout_minutes ]]; then
        echo "⛔ Ralph loop exceeded runtime limit (${timeout_minutes}m). Exiting."
        update_state_field "active" "false"
        update_state_field "exitReason" "timeout"
        if [[ "$persist_context" == "true" ]] && [[ -n "$task_dir" ]]; then
            update_context_file "$task_dir" "Exited: Runtime limit (${timeout_minutes}m) exceeded"
        fi
        exit 0
    fi
fi

# --- SAFETY CHECK 3: Stuck Detection ---
error_count=$(echo "$state" | jq -r ".errorCount[\"$last_error\"] // 0")
if [[ -n "$last_error" ]] && [[ $error_count -ge 3 ]]; then
    echo "⛔ Ralph loop stuck on repeated error. Generating escape analysis."
    update_state_field "active" "false"
    update_state_field "exitReason" "stuck_on_error"

    # Output escape analysis request
    cat << EOF
{"type":"user_input","content":"The Ralph loop has detected a stuck condition. The same error has occurred $error_count times:

Error: $last_error

Please analyze this situation and provide:
1. Root cause analysis
2. Suggested fixes
3. Whether to retry with modifications

The loop has been paused. Use /ralph-resume to continue after fixing the issue."}
EOF
    exit 0
fi

# --- SAFETY CHECK 4: Idle Detection (no file changes) ---
files_modified_count=$(echo "$state" | jq -r '.filesModified | length // 0')
last_file_change_iteration=$(echo "$state" | jq -r '.lastFileChangeIteration // 0')
idle_iterations=$((iteration - last_file_change_iteration))

if [[ $idle_iterations -ge 5 ]] && [[ $iteration -gt 5 ]]; then
    echo "⚠️ Ralph loop idle for $idle_iterations iterations (no file changes). Exiting."
    update_state_field "active" "false"
    update_state_field "exitReason" "idle"
    if [[ "$persist_context" == "true" ]] && [[ -n "$task_dir" ]]; then
        update_context_file "$task_dir" "Exited: No progress for $idle_iterations iterations"
    fi
    exit 0
fi

# --- QUALITY GATE CHECK ---
if [[ "$quality_gates" == "true" ]]; then
    gate_result=$(run_quality_gates)
    if [[ "$gate_result" != "pass" ]]; then
        echo "⚠️ Quality gates failed. Continuing with warning."
        update_state_field "lastQualityGateFailure" "$gate_result"
    fi
fi

# --- UPDATE ITERATION ---
new_iteration=$((iteration + 1))
update_state_field "iteration" "$new_iteration"

# --- CONTEXT SYNC ---
if [[ "$persist_context" == "true" ]] && [[ -n "$task_dir" ]]; then
    sync_context "$task_dir" "$new_iteration"
fi

# --- CONTINUE LOOP ---
# Output the user input that will restart Claude with the task
cat << EOF
{"type":"user_input","content":"[Ralph Loop - Iteration $new_iteration/$max_iterations]

Continue working on: $task_description

Previous iteration completed. Review .claude/ralph-state.json for current state.

Rules:
- Make meaningful progress this iteration
- Update filesModified in state when you change files
- If you encounter an error, update lastError in state
- When task is FULLY complete, output: <promise>$completion_promise</promise>

Continue now."}
EOF
