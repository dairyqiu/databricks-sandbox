---
description: Start an autonomous self-referential loop with built-in safeguards
argument-hint: "Task description" [--max-iterations N] [--completion-promise "text"] [--persist-context] [--quality-gates] [--timeout N]
---

You are entering an autonomous Ralph Wiggum loop. This is a powerful self-referential technique for completing complex tasks with minimal user intervention.

## Ralph Loop Configuration

Parse the user's arguments to configure this session:

**Arguments:**
- First quoted string: The task to complete
- `--max-iterations N`: Maximum iterations before forced exit (default: 50)
- `--completion-promise "text"`: Text to output when task is complete
- `--persist-context`: Enable dev-docs integration for crash recovery
- `--quality-gates`: Run tests/lint before each iteration continues
- `--timeout N`: Maximum runtime in minutes (default: 240)

## Loop State Initialization

Create Ralph state file at `.claude/ralph-state.json`:

```json
{
  "active": true,
  "taskDescription": "<parsed task>",
  "startTime": "<ISO timestamp>",
  "iteration": 0,
  "maxIterations": <parsed or 50>,
  "completionPromise": "<parsed or 'COMPLETE'>",
  "persistContext": <true/false>,
  "qualityGates": <true/false>,
  "timeoutMinutes": <parsed or 240>,
  "taskDir": "dev/active/ralph-<task-slug>",
  "lastError": null,
  "errorCount": {},
  "filesModified": [],
  "testsStatus": null
}
```

## Loop Execution Rules

1. **CRITICAL**: You MUST complete work within this turn, then the Stop hook will automatically restart you.

2. **Progress Tracking**: Each iteration should:
   - Read previous state from `.claude/ralph-state.json`
   - Increment iteration counter
   - Update `filesModified` array
   - Check for stuck conditions
   - Update context files if `persistContext` is true

3. **Completion Detection**: The loop exits when you output:
   ```
   <promise>COMPLETE</promise>
   ```
   Or your configured completion promise text.

4. **Safety Limits**: The loop will automatically exit if:
   - `iteration >= maxIterations`
   - Runtime exceeds `timeoutMinutes`
   - Same error occurs `stuckThreshold` (3) times consecutively
   - No file changes for 5+ iterations

## Task Execution

Now execute the task: **$ARGUMENTS**

1. Parse the arguments above
2. Initialize the state file
3. If `--persist-context` is set, create `dev/active/ralph-<task>/` structure
4. Begin working on the task
5. Make meaningful progress this iteration
6. When fully complete, output `<promise>COMPLETE</promise>`

Remember: You will be automatically re-invoked when this turn ends. Focus on making incremental progress.
