---
description: Start Ralph loop with automatic dev-docs context persistence
argument-hint: "Task description" [--max-iterations N] [--quality-gates] [--timeout N]
---

You are starting an integrated Ralph Wiggum autonomous loop with full dev-docs persistence for crash recovery.

## Command: /ralph-dev

This is a wrapper around `/ralph-loop` that automatically:
1. Enables `--persist-context` for dev-docs integration
2. Creates the `dev/active/ralph-[task]/` structure
3. Syncs context on EVERY iteration for maximum recoverability
4. Includes all safety safeguards by default

## Parse Arguments

From: `$ARGUMENTS`

Extract:
- **task**: First quoted string (required)
- **--max-iterations N**: Maximum iterations (default: 50)
- **--quality-gates**: Enable test/lint gates (default: enabled)
- **--timeout N**: Max runtime in minutes (default: 240)

## Initialize Ralph Dev Session

### Step 1: Create Task Slug

Generate a URL-safe slug from the task description:
- Lowercase
- Replace spaces with hyphens
- Remove special characters
- Limit to 30 characters

Example: "Build todo API with tests" → "build-todo-api-with-tests"

### Step 2: Initialize State File

Create `.claude/ralph-state.json`:

```json
{
  "active": true,
  "taskDescription": "<task>",
  "startTime": "<ISO timestamp>",
  "iteration": 0,
  "maxIterations": <N>,
  "completionPromise": "COMPLETE",
  "persistContext": true,
  "qualityGates": true,
  "timeoutMinutes": <N>,
  "taskDir": "dev/active/ralph-<slug>",
  "lastError": null,
  "errorCount": {},
  "filesModified": [],
  "lastFileChangeIteration": 0,
  "testsStatus": null,
  "paused": false
}
```

### Step 3: Create Dev-Docs Structure

Create `dev/active/ralph-<slug>/` with:

**<slug>-plan.md:**
```markdown
# Ralph Dev Session: <task>

**Started:** <timestamp>
**Max Iterations:** <N>
**Quality Gates:** Enabled

## Task Description

<full task description>

## Approach

(Will be updated as implementation progresses)

## Completion Criteria

Output `<promise>COMPLETE</promise>` when:
- All requirements are met
- Tests pass (if applicable)
- Code is clean and documented
```

**<slug>-context.md:**
(Created by ralph-context-sync.sh on first iteration)

**<slug>-tasks.md:**
```markdown
# <task> Tasks

**Status:** 🟡 IN PROGRESS
**Last Updated:** <timestamp>

## Main Tasks

- [ ] <task description>

## Discovered Tasks

(Additional tasks discovered during implementation)

## Completed

(Moved here when done)
```

### Step 4: Begin Loop

Output message to start the loop:

```
Ralph Dev session initialized!

Task: <task>
Directory: dev/active/ralph-<slug>/
Max Iterations: <N>
Quality Gates: Enabled
Context Sync: Every iteration

Beginning autonomous work. I will:
1. Make incremental progress each iteration
2. Update context files for crash recovery
3. Run quality gates before continuing
4. Exit when complete or safety limits reached

Starting iteration 1...
```

Then begin working on the task immediately.

## Important Rules

1. **Persist state changes**: Always update `.claude/ralph-state.json` when:
   - Files are modified (update `filesModified` array)
   - Errors occur (update `lastError` and `errorCount`)
   - Progress is made (context is auto-synced)

2. **Signal completion properly**: When task is FULLY complete:
   ```
   <promise>COMPLETE</promise>
   ```

3. **Handle errors gracefully**: If stuck:
   - Update `lastError` in state
   - Try alternative approaches
   - After 3 identical failures, loop will auto-pause

4. **Quality matters**: Quality gates run each iteration. Fix issues promptly.

## Execute Now

Parse `$ARGUMENTS` and initialize the Ralph Dev session.
