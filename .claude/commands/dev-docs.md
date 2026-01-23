---
description: Convert approved implementation plan into persistent task tracking structure
argument-hint: Feature name matching your approved plan (e.g., "authentication-system", "microservices-refactor")
---

You are a task tracking specialist. Convert the approved implementation plan into a persistent three-file structure that survives context resets.

## Instructions

### Step 0: Consider Git Worktree

Before creating task tracking structure:

1. Check if isolation would benefit this feature (multi-file changes, long-running work)
2. If yes and not already in worktree, suggest using `using-git-worktrees` skill
3. The worktree provides a clean baseline for the implementation

**Ask the user:** "This feature involves multiple files. Would you like to create an isolated worktree workspace first?"

---

1. **Locate the approved plan**:
   - Check `~/.claude/plans/` directory for recent plan files
   - Look for the most recent plan file (by modification time)
   - If no plan file exists, prompt: "No approved plan found. For complex features, I should enter plan mode first to create an implementation plan. Should I proceed with planning, or would you like to describe a simple task?"
   - Read the approved plan content

2. **Create task management structure**:
   - Create directory: `dev/active/[task-name]/` (relative to project root)
   - Generate three files based on the approved plan:
     - `[task-name]-plan.md` - Copy the approved plan from ~/.claude/plans/
     - `[task-name]-context.md` - Initialize with SESSION PROGRESS tracking template
     - `[task-name]-tasks.md` - Extract tasks from plan phases into checklist format
   - Include "Last Updated: YYYY-MM-DD" in each file

3. **Initialize tracking sections**:

   **In [task-name]-context.md:**
   - SESSION PROGRESS section at the top:
     ```markdown
     ## SESSION PROGRESS (YYYY-MM-DD)

     ### ✅ COMPLETED
     (empty - will be filled during implementation)

     ### 🟡 IN PROGRESS
     (empty - will be updated as work begins)

     ### ⚠️ BLOCKERS
     (empty - will note any issues discovered)
     ```
   - Key Files section (extract from plan's file references)
   - Important Decisions section (extract from plan's rationale)
   - Quick Resume instructions

   **In [task-name]-tasks.md:**
   - Convert plan phases into checkbox sections
   - Each task from plan becomes: `- [ ] Task description (File: path)`
   - Add acceptance criteria below each task
   - Use status indicators: ⏳ NOT STARTED, 🟡 IN PROGRESS, ✅ COMPLETE

## Quality Standards
- Plans must be self-contained with all necessary context
- Use clear, actionable language
- Include specific technical details where relevant
- Consider both technical and business perspectives
- Account for potential risks and edge cases

## Context References
- Check `PROJECT_KNOWLEDGE.md` for architecture overview (if exists)
- Consult `BEST_PRACTICES.md` for coding standards (if exists)
- Reference `TROUBLESHOOTING.md` for common issues to avoid (if exists)
- Use `dev/README.md` for task management guidelines (if exists)

### Step 6: Create Native Tasks

After creating the dev-docs files, also create a Tasks list for real-time UI tracking:

1. **Create parent tasks for each phase** in the plan:
   - Use `TaskCreate` for each phase/section heading
   - Include phase description and acceptance criteria
   - Set `activeForm` to present continuous (e.g., "Implementing authentication")

2. **Create child tasks for each checklist item** from `[task]-tasks.md`:
   - Use `TaskCreate` for each `- [ ]` item
   - Include file paths in task descriptions for navigation
   - Set `activeForm` appropriately (e.g., "Creating user model")

3. **Set up dependencies** between phases:
   - Use `TaskUpdate` with `addBlockedBy` to establish phase ordering
   - Phase 2 tasks blocked by Phase 1 completion, etc.

4. **Verify Tasks were created**:
   - Use `TaskList` to confirm tasks appear
   - Report task count to user

**Why both?**
- **Tasks**: Real-time UI for progress visibility during the session
- **Dev-docs**: Persistent source of truth that survives context resets/crashes
- If Tasks don't persist across sessions, dev-docs allows full recovery

---

**Workflow Integration:**
- For complex features: Claude enters plan mode → creates plan in `~/.claude/plans/` → user approves → `/dev-docs` converts to persistent tracking
- The plan files in `~/.claude/plans/` are session-scoped. This command persists them to `dev/active/` for context reset survival.
- Update progress frequently with `/dev-docs-update` command during implementation.
- Tasks provide in-session visibility; dev-docs provide cross-session persistence.