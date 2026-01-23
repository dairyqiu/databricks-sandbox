#!/bin/bash
set -e

# Ralph Iteration Guard Hook
# Enforces hard limits on Ralph loop iterations, runtime, and idle time
# Can be called from PreToolUse or as a standalone check

STATE_FILE="$CLAUDE_PROJECT_DIR/.claude/ralph-state.json"

# Check if Ralph is active
if [[ ! -f "$STATE_FILE" ]]; then
    exit 0
fi

state=$(cat "$STATE_FILE")
active=$(echo "$state" | jq -r '.active // false')

if [[ "$active" != "true" ]]; then
    exit 0
fi

# Configuration (can be overridden in state)
MAX_ITERATIONS=$(echo "$state" | jq -r '.maxIterations // 50')
TIMEOUT_MINUTES=$(echo "$state" | jq -r '.timeoutMinutes // 240')
IDLE_TIMEOUT_ITERATIONS=5

# Current values
iteration=$(echo "$state" | jq -r '.iteration // 0')
start_time=$(echo "$state" | jq -r '.startTime // ""')
last_file_change=$(echo "$state" | jq -r '.lastFileChangeIteration // 0')

# --- Check Max Iterations ---
if [[ $iteration -ge $MAX_ITERATIONS ]]; then
    echo "BLOCK: Ralph loop has reached maximum iterations ($MAX_ITERATIONS)"
    echo "REASON: Safety limit to prevent infinite loops"
    echo "ACTION: Review progress and decide whether to continue with /ralph-resume --extend"

    # Update state
    tmp="${STATE_FILE}.tmp"
    jq '.active = false | .exitReason = "max_iterations_guard"' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"

    exit 1
fi

# --- Check Runtime Limit ---
if [[ -n "$start_time" ]]; then
    # Calculate elapsed time (macOS compatible)
    start_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${start_time:0:19}" "+%s" 2>/dev/null || echo "0")
    now_epoch=$(date "+%s")
    elapsed_minutes=$(( (now_epoch - start_epoch) / 60 ))

    if [[ $elapsed_minutes -ge $TIMEOUT_MINUTES ]]; then
        echo "BLOCK: Ralph loop has exceeded runtime limit (${TIMEOUT_MINUTES} minutes)"
        echo "ELAPSED: ${elapsed_minutes} minutes"
        echo "ACTION: Review progress and decide whether to continue with /ralph-resume --extend-timeout"

        tmp="${STATE_FILE}.tmp"
        jq '.active = false | .exitReason = "runtime_limit_guard"' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"

        exit 1
    fi
fi

# --- Check Idle Timeout ---
idle_iterations=$((iteration - last_file_change))
if [[ $idle_iterations -ge $IDLE_TIMEOUT_ITERATIONS ]] && [[ $iteration -gt $IDLE_TIMEOUT_ITERATIONS ]]; then
    echo "WARNING: Ralph loop has been idle for $idle_iterations iterations"
    echo "HINT: No file changes detected. Consider:"
    echo "  1. The task may be stuck"
    echo "  2. The task may be complete but completion not signaled"
    echo "  3. Manual intervention may be needed"

    # Don't block, just warn - stuck detector will handle true stuck conditions
fi

# All checks passed
exit 0
