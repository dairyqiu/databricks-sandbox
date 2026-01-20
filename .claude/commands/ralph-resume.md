---
description: Resume a paused or crashed Ralph loop from saved context
argument-hint: [--extend N] [--extend-timeout N] [--reset-errors]
---

You are resuming a Ralph Wiggum autonomous loop from saved context.

## Resume Scenarios

### Scenario 1: Resume from Paused State

If `.claude/ralph-state.json` exists with `paused: true`:

1. Read the current state
2. Clear the pause flag
3. Apply any argument modifications:
   - `--extend N`: Add N to maxIterations
   - `--extend-timeout N`: Add N minutes to timeoutMinutes
   - `--reset-errors`: Clear errorCount and lastError
4. Set `active: true`
5. Continue from current iteration

### Scenario 2: Resume from Crash (No State File)

If `.claude/ralph-state.json` doesn't exist but `dev/active/ralph-*/` exists:

1. Find the most recent ralph task directory
2. Look for the latest checkpoint in `checkpoints/state-iteration-*.json`
3. Restore state from checkpoint
4. Read context from `*-context.md` and `*-tasks.md`
5. Resume from saved iteration

### Scenario 3: Resume Specific Task

If `$ARGUMENTS` contains a task name or path:

1. Look for matching `dev/active/ralph-<name>/`
2. Restore from that specific task's checkpoints
3. Resume execution

## Resume Process

### Step 1: Locate State

```bash
# Priority order:
1. .claude/ralph-state.json (if exists and not stale)
2. dev/active/ralph-*/checkpoints/state-iteration-*.json (latest)
3. User-specified task directory
```

### Step 2: Validate State

Check:
- State file is valid JSON
- Task description exists
- Iteration count is reasonable
- Files mentioned still exist

### Step 3: Apply Modifications

From `$ARGUMENTS`:
- `--extend N`: `maxIterations += N`
- `--extend-timeout N`: `timeoutMinutes += N`
- `--reset-errors`: `errorCount = {}, lastError = null`

### Step 4: Resume Message

Output:

```
╔═══════════════════════════════════════════════════════════╗
║               RALPH LOOP RESUMING                          ║
╚═══════════════════════════════════════════════════════════╝

📋 Task: <task description>
📍 Resuming from: Iteration <N>
📊 Max Iterations: <current/new max>
⏱️  Timeout: <current/new timeout> minutes

Changes Applied:
<list any --extend, --reset-errors modifications>

Context Restored:
- Files modified: <count>
- Last error: <error or cleared>
- Tests status: <status>

Resuming work now...
```

### Step 5: Continue Work

1. Set `active: true`, `paused: false`
2. Increment iteration
3. Review context file for where we left off
4. Continue the task from current state

## Error Handling

### No Recoverable State Found

```
⚠️  No Ralph loop state found to resume.

Checked:
- .claude/ralph-state.json (not found)
- dev/active/ralph-*/ (no directories)

To start a new loop:
  /ralph-dev "Your task description"
```

### Corrupted State

```
⚠️  Ralph state file is corrupted.

Options:
1. Restore from checkpoint:
   /ralph-resume --from-checkpoint <N>

2. Start fresh (preserves task directory):
   /ralph-dev "Same task" --resume-context

3. Cancel and review:
   /cancel-ralph
```

## Execute Now

Check for resumable state and begin the resume process.
