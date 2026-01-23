---
description: Show current Ralph loop status and progress metrics
---

You are displaying the current status of the Ralph Wiggum autonomous loop.

## Status Report

Read `.claude/ralph-state.json` and generate a comprehensive status report.

### If No Active Loop

If the state file doesn't exist or `active` is false:

```
╔═══════════════════════════════════════════════════════════╗
║               RALPH LOOP STATUS: INACTIVE                  ║
╚═══════════════════════════════════════════════════════════╝

No active Ralph loop.

To start a new loop:
  /ralph-loop "Your task description"

Or with dev-docs integration:
  /ralph-dev "Your task description"
```

### If Active Loop

Generate this report format:

```
╔═══════════════════════════════════════════════════════════╗
║               RALPH LOOP STATUS: ACTIVE                    ║
╚═══════════════════════════════════════════════════════════╝

📋 TASK
   <task description>

📊 PROGRESS
   Iteration:     <current> / <max>
   Runtime:       <elapsed> minutes (limit: <timeout>)
   Progress Bar:  [████████░░] <percentage>%

📁 FILES MODIFIED (<count>)
   <list of files, max 10, then "...and N more">

🧪 QUALITY STATUS
   Tests:         <pass/fail/unknown>
   Last Gate:     <pass/fail/not run>

⚠️  ISSUES
   Last Error:    <error or "None">
   Error Count:   <count for last error>
   Paused:        <yes/no>

💾 PERSISTENCE
   Context Dir:   <task dir or "Not enabled">
   Last Sync:     <timestamp or "N/A">
   Checkpoints:   <count> saved

═══════════════════════════════════════════════════════════

Commands:
  /cancel-ralph   Stop the loop
  /ralph-resume   Resume if paused
```

### If Paused

Add a prominent pause indicator:

```
⏸️  LOOP PAUSED
   Reason: <pause reason>

   Use /ralph-resume to continue after addressing the issue.
```

### Additional Details

If `--verbose` or `-v` is passed in arguments, also show:

1. **Full error history** from `errorCount` object
2. **All checkpoints** in the checkpoints directory
3. **Iteration log** (last 10 entries from `<task>-iterations.log`)
4. **Complete state JSON** (formatted)

## Execute Now

Read the state file and display the status report.
