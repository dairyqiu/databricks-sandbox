#!/bin/bash
set -e

# Ralph Stuck Detector Hook
# Detects when the Ralph loop is stuck on repeated failures
# Provides escape analysis and recommendations

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

# Configuration
STUCK_THRESHOLD=3  # Same error N times = stuck

# Get error tracking data
last_error=$(echo "$state" | jq -r '.lastError // ""')
error_count=$(echo "$state" | jq -r ".errorCount[\"$last_error\"] // 0" 2>/dev/null || echo "0")

# Check if stuck on same error
if [[ -n "$last_error" ]] && [[ "$last_error" != "null" ]] && [[ $error_count -ge $STUCK_THRESHOLD ]]; then
    iteration=$(echo "$state" | jq -r '.iteration // 0')
    task=$(echo "$state" | jq -r '.taskDescription // "unknown task"')

    echo "STUCK DETECTED: Same error occurred $error_count times"
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "ESCAPE ANALYSIS"
    echo "═══════════════════════════════════════════════════════"
    echo ""
    echo "Task: $task"
    echo "Iteration: $iteration"
    echo "Repeated Error: $last_error"
    echo ""
    echo "Possible Causes:"
    echo "  1. Missing dependency or configuration"
    echo "  2. Incorrect approach for the problem"
    echo "  3. External service unavailable"
    echo "  4. Permissions issue"
    echo "  5. Bug in implementation logic"
    echo ""
    echo "Recommended Actions:"
    echo "  1. Review the error message carefully"
    echo "  2. Check if prerequisites are met"
    echo "  3. Try an alternative approach"
    echo "  4. Ask for user guidance on the specific issue"
    echo ""
    echo "Commands:"
    echo "  /cancel-ralph      - Stop the loop and review"
    echo "  /ralph-resume      - Continue after fixing issue"
    echo "  /ralph-status      - View current progress"
    echo ""
    echo "═══════════════════════════════════════════════════════"

    # Update state to pause (not fully deactivate - allow resume)
    tmp="${STATE_FILE}.tmp"
    jq '.paused = true | .pauseReason = "stuck_on_error" | .escapeAnalysisGenerated = true' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"

    exit 1
fi

# Check for lack of progress (no file changes for many iterations)
iteration=$(echo "$state" | jq -r '.iteration // 0')
last_file_change=$(echo "$state" | jq -r '.lastFileChangeIteration // 0')
no_progress_iterations=$((iteration - last_file_change))

if [[ $no_progress_iterations -ge 5 ]] && [[ $iteration -gt 5 ]]; then
    echo "WARNING: No file changes for $no_progress_iterations iterations"
    echo ""
    echo "This may indicate:"
    echo "  1. Task is stuck on a research/planning phase"
    echo "  2. Task requires manual intervention"
    echo "  3. Task is complete but completion not signaled"
    echo ""
    echo "If the task is complete, output: <promise>COMPLETE</promise>"
    echo "If stuck, use /cancel-ralph to stop and review"
fi

exit 0
