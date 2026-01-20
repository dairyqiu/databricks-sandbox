#!/bin/bash
# Ralph Wiggum Utility Functions

STATE_FILE="$CLAUDE_PROJECT_DIR/.claude/ralph-state.json"

# Update a field in the state JSON file
update_state_field() {
    local field="$1"
    local value="$2"
    local tmp_file="${STATE_FILE}.tmp"

    if [[ -f "$STATE_FILE" ]]; then
        # Handle different value types
        if [[ "$value" =~ ^[0-9]+$ ]]; then
            # Numeric value
            jq ".$field = $value" "$STATE_FILE" > "$tmp_file" && mv "$tmp_file" "$STATE_FILE"
        elif [[ "$value" == "true" ]] || [[ "$value" == "false" ]]; then
            # Boolean value
            jq ".$field = $value" "$STATE_FILE" > "$tmp_file" && mv "$tmp_file" "$STATE_FILE"
        else
            # String value
            jq ".$field = \"$value\"" "$STATE_FILE" > "$tmp_file" && mv "$tmp_file" "$STATE_FILE"
        fi
    fi
}

# Get elapsed minutes since start time
get_elapsed_minutes() {
    local start_time="$1"
    local start_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${start_time:0:19}" "+%s" 2>/dev/null || echo "0")
    local now_epoch=$(date "+%s")
    local elapsed_seconds=$((now_epoch - start_epoch))
    echo $((elapsed_seconds / 60))
}

# Update context file for dev-docs integration
update_context_file() {
    local task_dir="$1"
    local message="$2"
    local context_file="$CLAUDE_PROJECT_DIR/$task_dir/$(basename "$task_dir")-context.md"

    if [[ -f "$context_file" ]]; then
        local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        # Append to the context file
        echo "" >> "$context_file"
        echo "### Update: $timestamp" >> "$context_file"
        echo "$message" >> "$context_file"
    fi
}

# Sync context for dev-docs integration (per-iteration)
sync_context() {
    local task_dir="$1"
    local iteration="$2"
    local context_file="$CLAUDE_PROJECT_DIR/$task_dir/$(basename "$task_dir")-context.md"
    local log_file="$CLAUDE_PROJECT_DIR/$task_dir/$(basename "$task_dir")-iterations.log"

    # Read current state
    local state=$(cat "$STATE_FILE")
    local files_modified=$(echo "$state" | jq -r '.filesModified | join(", ") // "none"')
    local last_error=$(echo "$state" | jq -r '.lastError // "none"')
    local tests_status=$(echo "$state" | jq -r '.testsStatus // "unknown"')

    # Append to iteration log
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Iteration $iteration | Files: $files_modified | Tests: $tests_status | Error: $last_error" >> "$log_file"

    # Update context file with latest state
    if [[ -f "$context_file" ]]; then
        # Create updated IN PROGRESS section
        local tmp_context="${context_file}.tmp"
        cat "$context_file" | sed '/^### 🟡 IN PROGRESS/,/^###/{
            /^### 🟡 IN PROGRESS/!{
                /^###/!d
            }
        }' > "$tmp_context"

        # Insert current progress
        sed -i '' "/^### 🟡 IN PROGRESS/a\\
\\
**Iteration:** $iteration\\
**Files Modified:** $files_modified\\
**Tests:** $tests_status\\
**Last Updated:** $timestamp\\
" "$tmp_context" 2>/dev/null || true

        mv "$tmp_context" "$context_file" 2>/dev/null || true
    fi
}

# Run quality gates (tests, lint, type check)
run_quality_gates() {
    local project_root="$CLAUDE_PROJECT_DIR"
    local result="pass"

    # Check for package.json with test script
    if [[ -f "$project_root/package.json" ]]; then
        if grep -q '"test"' "$project_root/package.json" 2>/dev/null; then
            # Run tests silently, capture exit code
            if ! npm test --silent 2>/dev/null; then
                result="tests_failed"
            fi
        fi

        # Check for TypeScript
        if [[ -f "$project_root/tsconfig.json" ]]; then
            if ! npx tsc --noEmit 2>/dev/null; then
                result="type_errors"
            fi
        fi

        # Check for lint script
        if grep -q '"lint"' "$project_root/package.json" 2>/dev/null; then
            if ! npm run lint --silent 2>/dev/null; then
                result="lint_errors"
            fi
        fi
    fi

    echo "$result"
}

# Increment error count for a specific error
increment_error_count() {
    local error="$1"
    local escaped_error=$(echo "$error" | sed 's/"/\\"/g' | head -c 200)
    local tmp_file="${STATE_FILE}.tmp"

    if [[ -f "$STATE_FILE" ]]; then
        jq ".errorCount[\"$escaped_error\"] = ((.errorCount[\"$escaped_error\"] // 0) + 1)" "$STATE_FILE" > "$tmp_file" && mv "$tmp_file" "$STATE_FILE"
    fi
}

# Add file to modified list
add_modified_file() {
    local file="$1"
    local tmp_file="${STATE_FILE}.tmp"

    if [[ -f "$STATE_FILE" ]]; then
        jq ".filesModified += [\"$file\"] | .filesModified |= unique | .lastFileChangeIteration = .iteration" "$STATE_FILE" > "$tmp_file" && mv "$tmp_file" "$STATE_FILE"
    fi
}

# Check if completion was signaled in output
check_completion() {
    local output="$1"
    local completion_promise=$(jq -r '.completionPromise // "COMPLETE"' "$STATE_FILE")

    if echo "$output" | grep -q "<promise>$completion_promise</promise>"; then
        update_state_field "active" "false"
        update_state_field "exitReason" "completed"
        return 0
    fi
    return 1
}
