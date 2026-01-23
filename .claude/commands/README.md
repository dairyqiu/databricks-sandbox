# Universal Slash Commands

**Eight essential commands available in the base template**

These commands work across ALL projects regardless of tech stack - AI research, web apps, Mac apps, data science, etc.

**Note:** Planning now uses Claude Code's built-in plan mode (EnterPlanMode) instead of a custom `/plan` command.

---

## Available Commands

### Development & Documentation

#### /dev-docs

**Purpose:** Convert approved plan into persistent task tracking structure

**Usage:**
```
/dev-docs implement-real-time-notifications
```

**What It Does:**
- Reads approved plan from `~/.claude/plans/` (created by built-in plan mode)
- Creates a `dev/active/[task-name]/` directory
- Generates three files:
  - `[task-name]-plan.md` - Copies the approved plan
  - `[task-name]-context.md` - SESSION PROGRESS tracking template
  - `[task-name]-tasks.md` - Checklist extracted from plan

**When to Use:**
- After Claude creates and you approve a plan in plan mode
- To persist session-scoped plans for context reset survival
- Complex multi-day tasks spanning multiple sessions

**Workflow:**
1. Claude enters plan mode for complex features (automatic)
2. You approve the plan
3. Run `/dev-docs [feature-name]` to persist it

**Learn More:** See [../../dev/README.md](../../dev/README.md)

---

#### /dev-docs-update

**Purpose:** Update existing dev docs before context reset

**Usage:**
```
/dev-docs-update
```

**What It Does:**
- Updates `SESSION PROGRESS` in context.md
- Marks completed tasks in tasks.md
- Adds newly discovered tasks
- Captures current state for resuming later

**When to Use:**
- Before approaching context limits
- Before ending work session
- After completing major milestones

**Learn More:** See [../../dev/README.md](../../dev/README.md)

---

### Code Quality

#### /code-review

**Purpose:** Comprehensive code review with severity levels

**Usage:**
```
/code-review
```

**What It Does:**
- Invokes the **code-reviewer agent**
- Reviews code for quality and security
- Categorizes issues (CRITICAL, HIGH, MEDIUM, LOW)
- Identifies bugs and suggests improvements

**When to Use:**
- After implementing features
- Before commits
- Security-critical code
- Code quality checks

---

### Test-Driven Development

#### /tdd

**Purpose:** Enforce test-driven development workflow

**Usage:**
```
/tdd implement user registration
```

**What It Does:**
- Invokes the **tdd-guide agent**
- Enforces RED → GREEN → REFACTOR cycle
- Guides test-first development
- Ensures 80%+ test coverage

**When to Use:**
- New feature implementation
- Bug fixes
- Critical business logic
- Regression prevention

---

### Build & Troubleshooting

#### /build-fix

**Purpose:** Fix build and compilation errors

**Usage:**
```
/build-fix
```

**What It Does:**
- Invokes the **build-error-resolver agent**
- Analyzes build error messages
- Diagnoses root causes
- Suggests and applies fixes

**When to Use:**
- Build failures
- TypeScript compilation errors
- Bundling issues
- Dependency problems

---

### Ralph Autonomous Loop

#### /ralph-dev

**Purpose:** Start autonomous coding loop with dev-docs persistence

**Usage:**
```
/ralph-dev "Build a REST API with authentication and tests"
```

**What It Does:**
- Creates persistent task structure in `dev/active/ralph-<task>/`
- Automatically continues work across turns without user input
- Syncs context every iteration for crash recovery
- Enables quality gates (tests/lint) by default
- Creates checkpoints for recovery

**When to Use:**
- Complex multi-step features
- Long-running implementation tasks
- When you want hands-off autonomous development
- Tasks that benefit from automatic progress tracking

**Options:**
- `--max-iterations N` (default: 50) - Maximum loop iterations
- `--timeout N` (default: 240) - Max runtime in minutes
- `--quality-gates` (default: enabled) - Run tests/lint each iteration

---

#### /ralph-status

**Purpose:** Show current Ralph loop status and metrics

**Usage:**
```
/ralph-status
/ralph-status --verbose
```

**What It Does:**
- Displays task description and progress
- Shows current iteration and limits
- Lists modified files
- Reports quality/test status
- Shows error tracking and pause state

**When to Use:**
- Check progress on long-running loops
- Debug stuck or paused loops
- Review what files have been modified

---

#### /ralph-resume

**Purpose:** Resume paused or crashed Ralph loop

**Usage:**
```
/ralph-resume
/ralph-resume --extend 20
/ralph-resume --reset-errors
```

**What It Does:**
- Restores state from latest checkpoint
- Clears pause flag and continues execution
- Can extend iteration limits or reset error counts

**When to Use:**
- After context reset or crash
- When loop paused due to stuck detection
- To add more iterations to a running task

**Options:**
- `--extend N` - Add N iterations to max limit
- `--extend-timeout N` - Add N minutes to timeout
- `--reset-errors` - Clear error counts and retry

---

## Why These Are in Base Template

These 8 commands are **universal** - they apply to ALL project types:
- **Development tracking** (/dev-docs, /dev-docs-update) - Essential for context management across sessions
- **Code quality** (/code-review) - Universal across all languages
- **Testing** (/tdd) - Test-driven development applies everywhere
- **Build troubleshooting** (/build-fix) - All projects have builds
- **Autonomous loops** (/ralph-dev, /ralph-status, /ralph-resume) - Hands-off development for complex tasks

**Note on Planning:** Claude Code's built-in plan mode (EnterPlanMode) handles planning automatically for complex features. No custom command needed.

They work regardless of:
- Programming language (Python, TypeScript, Swift, Go, etc.)
- Framework (React, Express, Django, SwiftUI, etc.)
- Project type (web apps, ML, native apps, data science, etc.)
- Tech stack

**Philosophy:** Essential workflows that every project needs, not domain-specific shortcuts.

---

## Integration with Dev Docs Pattern

The `dev/` directory in this template demonstrates the dev docs pattern:

**Structure:**
```
dev/
├── README.md              # Dev docs pattern documentation
└── active/                # Current work
    └── [task-name]/
        ├── [task-name]-plan.md
        ├── [task-name]-context.md
        └── [task-name]-tasks.md
```

**Workflow:**
1. Start task with `/dev-docs [task-name]`
2. Work on implementation
3. Update frequently with `/dev-docs-update`
4. Context resets? Read the three files and resume instantly

---

## Optional Specialized Commands

For domain-specific commands, see [../../optional-components/commands/README.md](../../optional-components/commands/README.md):

**Testing:**
- `/e2e` - End-to-end testing with Playwright
- `/test-coverage` - Analyze test coverage

**Workflow:**
- `/refactor-clean` - Dead code identification
- `/update-docs` - Documentation synchronization

**Research:**
- `/route-research` - Research API routes for testing

**Note:** The most universal commands (/code-review, /tdd, /build-fix, /dev-docs) are in the base template above. Planning uses built-in plan mode.

---

## Creating Custom Commands

Commands are markdown files in `.claude/commands/` that Claude Code recognizes:

**Example Structure:**
```markdown
---
name: my-command
description: What this command does
---

# My Command Implementation

Instructions for Claude on how to execute this command...
```

See existing commands for examples.

---

## Learn More

- **Main guide:** [../../README.md](../../README.md)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Dev docs pattern:** [../../dev/README.md](../../dev/README.md)
- **Optional commands:** [../../optional-components/commands/README.md](../../optional-components/commands/README.md)
