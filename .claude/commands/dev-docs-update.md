---
description: Update dev documentation before context compaction
argument-hint: Optional - specific context or tasks to focus on (leave empty for comprehensive update)
---

We're approaching context limits. Please update the development documentation to ensure seamless continuation after context reset.

## Required Updates

### 1. Update Active Task Documentation
For each task in `/dev/active/`:
- Update `[task-name]-context.md` with:
  - Current implementation state
  - Key decisions made this session
  - Files modified and why
  - Any blockers or issues discovered
  - Next immediate steps
  - Last Updated timestamp

- Update `[task-name]-tasks.md` with:
  - Mark completed tasks as ✅ 
  - Add any new tasks discovered
  - Update in-progress tasks with current status
  - Reorder priorities if needed

### 2. Capture Session Context
Include any relevant information about:
- Complex problems solved
- Architectural decisions made
- Tricky bugs found and fixed
- Integration points discovered
- Testing approaches used
- Performance optimizations made

### 3. Update Memory (if applicable)
- Store any new patterns or solutions in project memory/documentation
- Update entity relationships discovered
- Add observations about system behavior

### 4. Document Unfinished Work
- What was being worked on when context limit approached
- Exact state of any partially completed features
- Commands that need to be run on restart
- Any temporary workarounds that need permanent fixes

### 5. Create Handoff Notes
If switching to a new conversation:
- Exact file and line being edited
- The goal of current changes
- Any uncommitted changes that need attention
- Test commands to verify work

### 6. Sync Native Tasks

After updating dev-docs files, sync the Tasks list to match:

1. **Read current task state** from `[task]-tasks.md`
2. **Update Tasks status** to match dev-docs checkbox state:
   - `- [x]` items → `TaskUpdate` with `status: "completed"`
   - `- [ ]` items being worked on → `status: "in_progress"`
   - New discovered tasks → `TaskCreate`
3. **Verify sync** with `TaskList`

This keeps Tasks (the UI) in sync with dev-docs (the source of truth).

### 7. Show "What Changed?" Summary

Read from tracker cache and display a session summary:

1. **Check for tracker data** at `.claude/tsc-cache/*/`:
   - `edited-files.log` - Files modified this session
   - `affected-repos.txt` - Repos with changes
   - `commands.txt` - Suggested build/typecheck commands

2. **Display summary** (if data exists):
   ```
   ## What Changed This Session

   ### Most-Edited Files
   - path/to/file.ts (3 edits)
   - path/to/other.ts (2 edits)

   ### Affected Areas
   - frontend
   - backend/api

   ### Suggested Commands
   - cd frontend && pnpm build
   - cd backend && npx tsc --noEmit
   ```

3. **If no tracker data**, skip this section gracefully.

This provides a quick overview of session changes for the user.

---

## Additional Context: $ARGUMENTS

**Priority**: Focus on capturing information that would be hard to rediscover or reconstruct from code alone.