---
description: Start a new feature with automatic tracking setup
argument-hint: "Feature name" [--ralph for autonomous mode] [--strict-tdd for blocking]
---

# Feature Command

Single entrypoint for feature development that sets up proper tracking and enforces TDD.

## Usage

```
/feature auth-system              # Manual mode
/feature auth-system --ralph      # Autonomous mode (Ralph loop)
/feature auth-system --strict-tdd # Enforce TDD blocking
```

## Parse Arguments

From: `$ARGUMENTS`

Extract:
- **feature**: Feature name (first argument or quoted string)
- **--ralph**: Flag for autonomous mode (optional)
- **--strict-tdd**: Flag to enforce TDD blocking (optional)

## Behavior

### Step 1: Enter Plan Mode

Use `EnterPlanMode` to create an implementation plan:
- Explore relevant codebase areas
- Design implementation approach
- Identify files to create/modify
- Plan phases and dependencies

Wait for user to approve the plan via `ExitPlanMode`.

### Step 2: Create Persistent Tracking

After plan approval, run `/dev-docs <feature-name>`:
- Creates `dev/active/<feature>/` structure
- Copies approved plan from `~/.claude/plans/`
- Initializes context and tasks files
- **Creates Native Tasks** for real-time UI visibility

### Step 3: Start TDD Workflow

**Automatic:** After tracking is set up, invoke `tdd-guide` agent:
- Create integration test scaffold (Walking Skeleton)
- Scaffold empty functions that compile but fail
- This ensures tests exist BEFORE implementation

Report: "TDD scaffold created. Integration test ready."

### Step 4: Branch by Mode

**If `--ralph` flag is present:**
- Transition to `/ralph-dev "<feature-name>"`
- Autonomous implementation begins with TDD enforcement
- Use `/ralph-status` to monitor progress
- Use `/ralph-resume` if interrupted

**If no flag (manual mode):**
- Report: "Feature tracking initialized. TDD scaffold ready."
- User drives the work manually
- Use `/dev-docs-update` periodically to sync progress
- Tasks show real-time status; dev-docs persist for recovery

---

## Workflows

### Manual Workflow
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  /feature   │───▶│  Plan Mode  │───▶│  /dev-docs  │
└─────────────┘    └─────────────┘    └─────────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │  TDD Scaffold   │
                                    │  (auto-created) │
                                    └─────────────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │ Manual Work +   │
                                    │ /dev-docs-update│
                                    └─────────────────┘
```

### Autonomous Workflow
```
┌─────────────────┐    ┌─────────────┐    ┌─────────────┐
│ /feature --ralph│───▶│  Plan Mode  │───▶│  /dev-docs  │
└─────────────────┘    └─────────────┘    └─────────────┘
                                                │
                                                ▼
                                       ┌─────────────────┐
                                       │   /ralph-dev    │
                                       │  (TDD enforced) │
                                       └─────────────────┘
                                                │
                              ┌─────────────────┴─────────────────┐
                              ▼                                   ▼
                     ┌─────────────────┐                ┌─────────────────┐
                     │  /ralph-status  │                │  /ralph-resume  │
                     └─────────────────┘                └─────────────────┘
```

---

## TDD Integration

The feature command ensures TDD compliance by:

1. **Creating integration test first** (Walking Skeleton approach)
2. **Scaffolding empty implementation** (compiles but fails)
3. **Blocking edits without tests** (if TDD enforcement enabled)

### Example TDD Scaffold

After `/feature checkout-flow`, you get:

```
src/services/
├── checkout.integration.test.ts  # Created first (fails)
└── checkout.ts                    # Scaffold (throws NotImplemented)
```

---

## When to Use Each Mode

**Manual mode** (default):
- When you want fine-grained control
- For learning/understanding the codebase
- When requirements may evolve mid-implementation
- For features requiring frequent user input

**Ralph mode** (`--ralph`):
- Well-defined features with clear requirements
- Hands-off development
- Long-running implementations
- When you trust the plan and want autonomous execution

**Strict TDD** (`--strict-tdd`):
- Critical features requiring test-first discipline
- Team onboarding to TDD practices
- When you want Claude to enforce test creation

---

## Example Session

```
User: /feature user-auth

Claude: Entering plan mode for user-auth feature...

[Plan Mode]
- Explores auth patterns in codebase
- Designs implementation approach
- Creates plan with phases

Claude: Plan complete. Review and approve.

User: Looks good, proceed.

[After approval]
Claude: Creating dev-docs tracking...
Claude: Creating TDD scaffold...

✅ Created: src/services/auth.integration.test.ts
   - Test: "authenticates valid user"
   - Test: "rejects invalid credentials"

✅ Created: src/services/auth.ts (scaffold)
   - authenticateUser() throws NotImplemented
   - generateToken() throws NotImplemented

Feature tracking initialized. TDD scaffold ready.

Run tests to see RED state, then implement to GREEN.
```

---

## Related Commands

- `/dev-docs` - Create persistent tracking
- `/dev-docs-update` - Sync progress
- `/tdd` - Manual TDD workflow
- `/tdd-check` - Verify compliance
- `/ralph-dev` - Autonomous mode
- `/ralph-status` - Check Ralph progress

---

## Execute Now

Parse `$ARGUMENTS` and begin the feature workflow with TDD scaffold.
