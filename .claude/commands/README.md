# Universal Slash Commands

**Six essential commands available in the base template**

These commands work across ALL projects regardless of tech stack - AI research, web apps, Mac apps, data science, etc.

---

## Available Commands

### Development & Documentation

#### /dev-docs

**Purpose:** Create development documentation for tracking complex features

**Usage:**
```
/dev-docs implement real-time notifications
```

**What It Does:**
- Creates a `dev/active/[task-name]/` directory
- Generates three files:
  - `[task-name]-plan.md` - Strategic implementation plan
  - `[task-name]-context.md` - Key decisions and current progress
  - `[task-name]-tasks.md` - Checklist of tasks

**When to Use:**
- Complex multi-day tasks
- Features with many moving parts
- Work spanning multiple sessions
- Tasks needing careful planning

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

### Planning & Architecture

#### /plan

**Purpose:** Create comprehensive implementation plans for complex features

**Usage:**
```
/plan add user authentication
```

**What It Does:**
- Invokes the **planner agent** (uses Opus model)
- Four-phase planning (Understanding → Analysis → Design → Validation)
- Considers dependencies and risks
- Provides step-by-step implementation approach

**When to Use:**
- Complex features with multiple parts
- Architectural decisions needed
- Uncertain implementation approach
- High-risk changes

---

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

## Why These Are in Base Template

These 6 commands are **universal** - they apply to ALL project types:
- **Development tracking** (/dev-docs, /dev-docs-update) - Essential for context management
- **Planning** (/plan) - Every project needs implementation planning
- **Code quality** (/code-review) - Universal across all languages
- **Testing** (/tdd) - Test-driven development applies everywhere
- **Build troubleshooting** (/build-fix) - All projects have builds

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

**Note:** The 4 most universal commands (/plan, /code-review, /tdd, /build-fix) have been moved to the base template above.

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
