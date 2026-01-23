---
description: Cancel the current Ralph Wiggum autonomous loop
---

You are cancelling the current Ralph Wiggum autonomous loop.

## Cancellation Steps

1. **Update Ralph State**:
   - Read `.claude/ralph-state.json`
   - Set `active` to `false`
   - Add `cancelledAt` timestamp
   - Add `cancelReason` if provided

2. **Preserve Context**:
   If `persistContext` was enabled:
   - Update `dev/active/ralph-<task>/<task>-context.md` with:
     ```markdown
     ## SESSION CANCELLED (YYYY-MM-DD HH:MM)

     Cancelled after iteration: <N>
     Files modified: <count>
     Last action: <description>

     Resume with: /ralph-resume
     ```

3. **Report Summary**:
   Output a summary of what was accomplished:
   - Total iterations completed
   - Files created/modified
   - Tests status if quality gates were enabled
   - Any errors encountered

4. **Clean Exit**:
   Do NOT output `<promise>COMPLETE</promise>` or any completion signal.
   The loop will naturally stop since `active` is now `false`.

## Execute Cancellation

Read the current state and perform cancellation now.
