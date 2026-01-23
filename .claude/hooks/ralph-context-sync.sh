#!/bin/bash
set -e

# Ralph Context Sync Hook
# Synchronizes Ralph loop state with dev-docs persistence structure
# Called on each iteration to enable crash recovery

STATE_FILE="$CLAUDE_PROJECT_DIR/.claude/ralph-state.json"

# Check if Ralph is active with context persistence enabled
if [[ ! -f "$STATE_FILE" ]]; then
    exit 0
fi

state=$(cat "$STATE_FILE")
active=$(echo "$state" | jq -r '.active // false')
persist_context=$(echo "$state" | jq -r '.persistContext // false')
task_dir=$(echo "$state" | jq -r '.taskDir // ""')

if [[ "$active" != "true" ]] || [[ "$persist_context" != "true" ]] || [[ -z "$task_dir" ]]; then
    exit 0
fi

# Ensure full path
TASK_DIR="$CLAUDE_PROJECT_DIR/$task_dir"
TASK_NAME=$(basename "$task_dir")

# Create directory structure if it doesn't exist
mkdir -p "$TASK_DIR"

# Extract state values
iteration=$(echo "$state" | jq -r '.iteration // 0')
max_iterations=$(echo "$state" | jq -r '.maxIterations // 50')
task_description=$(echo "$state" | jq -r '.taskDescription // ""')
start_time=$(echo "$state" | jq -r '.startTime // ""')
files_modified=$(echo "$state" | jq -r '.filesModified | join(", ") // "none"')
files_count=$(echo "$state" | jq -r '.filesModified | length // 0')
last_error=$(echo "$state" | jq -r '.lastError // "none"')
tests_status=$(echo "$state" | jq -r '.testsStatus // "unknown"')
completion_promise=$(echo "$state" | jq -r '.completionPromise // "COMPLETE"')

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
DATE_ONLY=$(date "+%Y-%m-%d")

# --- Update Context File ---
CONTEXT_FILE="$TASK_DIR/${TASK_NAME}-context.md"

if [[ ! -f "$CONTEXT_FILE" ]]; then
    # Create initial context file
    cat > "$CONTEXT_FILE" << EOF
# $TASK_NAME Context

**Task:** $task_description
**Started:** $start_time
**Completion Signal:** \`<promise>$completion_promise</promise>\`

---

## SESSION PROGRESS ($DATE_ONLY)

### ✅ COMPLETED
(Updated automatically as work progresses)

### 🟡 IN PROGRESS

**Iteration:** $iteration / $max_iterations
**Files Modified:** $files_count files
**Tests:** $tests_status
**Last Updated:** $TIMESTAMP

### ⚠️ BLOCKERS
${last_error:+- $last_error}

---

## Key Files

(Files modified during this session)
$files_modified

---

## Important Decisions

(Key decisions made during implementation - updated by Claude)

---

## Quick Resume

To resume this task after a context reset:
\`\`\`
/ralph-resume
\`\`\`

Or manually:
1. Read this context file
2. Read ${TASK_NAME}-tasks.md for remaining work
3. Continue from last iteration
EOF
else
    # Update existing context file with current progress
    # Create a temporary updated section
    PROGRESS_UPDATE="**Iteration:** $iteration / $max_iterations
**Files Modified:** $files_count files
**Tests:** $tests_status
**Last Updated:** $TIMESTAMP"

    # Use sed to update the IN PROGRESS section
    # This is a simplified update - appends latest status
    tmp_file="${CONTEXT_FILE}.tmp"
    sed "s/\*\*Iteration:\*\*.*/$(echo "$PROGRESS_UPDATE" | head -1 | sed 's/[&/\]/\\&/g')/" "$CONTEXT_FILE" > "$tmp_file" 2>/dev/null || cp "$CONTEXT_FILE" "$tmp_file"
    mv "$tmp_file" "$CONTEXT_FILE"
fi

# --- Update Iteration Log ---
LOG_FILE="$TASK_DIR/${TASK_NAME}-iterations.log"

# Append iteration entry
echo "[$TIMESTAMP] Iteration $iteration | Files: $files_count | Tests: $tests_status | Error: $last_error" >> "$LOG_FILE"

# --- Update Tasks File ---
TASKS_FILE="$TASK_DIR/${TASK_NAME}-tasks.md"

if [[ ! -f "$TASKS_FILE" ]]; then
    # Create initial tasks file
    cat > "$TASKS_FILE" << EOF
# $TASK_NAME Tasks

**Status:** 🟡 IN PROGRESS
**Last Updated:** $TIMESTAMP

---

## Progress

- [ ] Complete task: $task_description

---

## Iteration Summary

| Iteration | Files Changed | Tests | Status |
|-----------|---------------|-------|--------|
| $iteration | $files_count | $tests_status | in_progress |

---

## Notes

(Add implementation notes here)
EOF
fi

# --- Create State Checkpoint ---
# Save a numbered checkpoint for recovery
CHECKPOINT_DIR="$TASK_DIR/checkpoints"
mkdir -p "$CHECKPOINT_DIR"
cp "$STATE_FILE" "$CHECKPOINT_DIR/state-iteration-${iteration}.json"

# Keep only last 10 checkpoints to save space
ls -t "$CHECKPOINT_DIR"/state-iteration-*.json 2>/dev/null | tail -n +11 | xargs rm -f 2>/dev/null || true

echo "Context synced for iteration $iteration"
exit 0
