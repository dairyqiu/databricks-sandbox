# Optional Commands

**Slash commands for quick access to common workflows**

This directory contains 9 optional slash commands - 1 from the original repository and 9 from everything-claude-code. Commands provide quick access to specialized workflows and agents.

**Note:** The `/dev-docs` and `/dev-docs-update` commands have been moved to the base template at [../../.claude/commands/](../../.claude/commands/) because they're universally useful for tracking features across all project types.

---

## What Are Slash Commands?

Slash commands (also called "skills" in Claude Code terminology) are shortcuts that:
- Start with `/` (e.g., `/tdd`, `/plan`, `/commit`)
- Trigger specialized workflows
- Often invoke agents or skills
- Provide quick access to common tasks

**How they work:**
1. User types `/command-name` in Claude
2. Claude loads the command file
3. Command instructions guide the workflow

---

## Quick Reference

| Command | Source | Purpose |
|---------|--------|---------|
| [/route-research](#route-research) | Original | Research routes for testing |
| [/tdd](#tdd) | everything-cc | Test-driven development workflow |
| [/plan](#plan) | everything-cc | Feature planning with planner agent |
| [/e2e](#e2e) | everything-cc | E2E testing with Playwright |
| [/code-review](#code-review) | everything-cc | Code review workflow |
| [/build-fix](#build-fix) | everything-cc | Build error resolution |
| [/refactor-clean](#refactor-clean) | everything-cc | Dead code cleanup |
| [/test-coverage](#test-coverage) | everything-cc | Test coverage analysis |
| [/update-codemaps](#update-codemaps) | everything-cc | Update code documentation |
| [/update-docs](#update-docs) | everything-cc | Documentation synchronization |

**Base Commands (in [../../.claude/commands/](../../.claude/commands/)):**
- `/dev-docs` - Create development documentation (moved to base)
- `/dev-docs-update` - Update development documentation (moved to base)

---

## From Original Repository

### /route-research

**Purpose:** Research and document API routes for testing purposes.

**Use When:**
- Planning API tests
- Understanding route structure
- Before using route-tester skill
- Creating test plans

**What It Does:**
1. Scans codebase for route definitions
2. Identifies authentication requirements
3. Documents request/response formats
4. Lists all endpoints with methods
5. Provides testing recommendations

**Integration:**

```bash
cp optional-components/commands/route-research-for-testing.md .claude/commands/
```

**Usage:**

```
/route-research
```

**Output:**
- List of all routes (GET, POST, PUT, DELETE)
- Authentication requirements per route
- Expected request bodies
- Response formats
- Suggested test cases

**Customization:**
- Update route file patterns for your framework
- Adjust for your authentication method
- Add custom documentation fields

---

## From everything-claude-code

### /tdd

**Purpose:** Enforce test-driven development workflow (RED → GREEN → REFACTOR).

**Use When:**
- Implementing new features
- Fixing bugs
- Any code changes requiring tests

**What It Does:**
1. Invokes **tdd-guide** agent
2. Ensures tests written BEFORE implementation
3. Guides through RED → GREEN → REFACTOR cycle
4. Validates 80%+ test coverage
5. Reviews test quality

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/tdd.md .claude/commands/

# 2. Ensure tdd-guide agent is available
cp optional-components/agents/tdd-guide.md .claude/agents/

# 3. Optional: Add tdd-workflow skill
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

**Usage:**

```
/tdd implement user registration
```

**Workflow:**
1. Write failing test (RED)
2. Run test - verify it fails
3. Write minimal implementation (GREEN)
4. Run test - verify it passes
5. Refactor code (IMPROVE)
6. Verify coverage meets 80%

---

### /plan

**Purpose:** Create comprehensive implementation plan using **planner agent** (Opus model).

**Use When:**
- Complex feature implementation
- Major refactoring
- Architectural changes
- Multi-step projects

**What It Does:**
1. Invokes **planner** agent (uses Opus for deep reasoning)
2. Four-phase planning:
   - Understanding (gather context)
   - Analysis (evaluate options)
   - Design (detailed plan)
   - Validation (review and approval)
3. Creates step-by-step implementation guide

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/plan.md .claude/commands/

# 2. Ensure planner agent is available
cp optional-components/agents/planner.md .claude/agents/
```

**Usage:**

```
/plan add real-time notifications
```

**Output:**
- Comprehensive implementation plan
- Phase breakdown
- Dependencies identified
- Risk assessment
- Time estimates
- User approval checkpoint

**Note:** Uses Opus 4.5 for maximum reasoning depth.

---

### /e2e

**Purpose:** End-to-end testing with Playwright using **e2e-runner** agent.

**Use When:**
- Testing critical user flows
- Regression testing
- Creating E2E test suites
- Debugging E2E failures

**What It Does:**
1. Invokes **e2e-runner** agent
2. Writes or runs Playwright tests
3. Debugs test failures
4. Provides test recommendations

**Requirements:**
- Playwright installed
- E2E test setup

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/e2e.md .claude/commands/

# 2. Ensure e2e-runner agent is available
cp optional-components/agents/e2e-runner.md .claude/agents/
```

**Usage:**

```
/e2e test checkout flow
```

**Capabilities:**
- Create new E2E tests
- Run existing test suites
- Debug failing tests
- Generate test reports

---

### /code-review

**Purpose:** Comprehensive code review using **code-reviewer** agent.

**Use When:**
- After writing any code
- Before committing
- Pull request preparation
- Refactoring review

**What It Does:**
1. Invokes **code-reviewer** agent
2. Reviews recent code changes
3. Identifies issues with severity levels:
   - CRITICAL (must fix)
   - HIGH (should fix)
   - MEDIUM (nice to fix)
   - LOW (optional)
4. Checks security, quality, tests
5. Provides improvement suggestions

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/code-review.md .claude/commands/

# 2. Ensure code-reviewer agent is available
cp optional-components/agents/code-reviewer.md .claude/agents/
```

**Usage:**

```
/code-review
```

**Output:**
- Categorized issues by severity
- Security vulnerabilities
- Code quality concerns
- Test coverage gaps
- Specific fix recommendations

---

### /build-fix

**Purpose:** Troubleshoot and fix build errors using **build-error-resolver** agent.

**Use When:**
- Build failing
- Dependency conflicts
- Configuration issues
- Module resolution errors

**What It Does:**
1. Invokes **build-error-resolver** agent
2. Analyzes build error output
3. Identifies root causes
4. Suggests fixes incrementally
5. Verifies after each fix

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/build-fix.md .claude/commands/

# 2. Ensure build-error-resolver agent is available
cp optional-components/agents/build-error-resolver.md .claude/agents/
```

**Usage:**

```
/build-fix
```

**Handles:**
- TypeScript errors
- Webpack/Vite errors
- Dependency conflicts
- Configuration issues
- Import/export problems

---

### /refactor-clean

**Purpose:** Identify and remove dead code using **refactor-cleaner** agent.

**Use When:**
- Code cleanup needed
- After major refactoring
- Removing unused features
- Reducing bundle size

**What It Does:**
1. Invokes **refactor-cleaner** agent
2. Scans for unused exports
3. Identifies dead code paths
4. Finds unused imports
5. Locates deprecated patterns
6. Suggests safe removals

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/refactor-clean.md .claude/commands/

# 2. Ensure refactor-cleaner agent is available
cp optional-components/agents/refactor-cleaner.md .claude/agents/
```

**Usage:**

```
/refactor-clean
```

**Output:**
- List of unused exports
- Dead code locations
- Safe removal recommendations
- Impact analysis

---

### /test-coverage

**Purpose:** Analyze test coverage and identify gaps.

**Use When:**
- Checking coverage metrics
- Identifying untested code
- Meeting coverage requirements
- Before releasing features

**What It Does:**
1. Runs test suite with coverage
2. Analyzes coverage reports
3. Identifies uncovered code
4. Suggests tests to write
5. Reports on coverage trends

**Requirements:**
- Test framework with coverage (Jest, Vitest, etc.)

**Integration:**

```bash
cp optional-components/commands/test-coverage.md .claude/commands/
```

**Usage:**

```
/test-coverage
```

**Output:**
- Overall coverage percentage
- Coverage by file/directory
- Uncovered lines
- Suggested tests to write
- Coverage trend

---

### /update-codemaps

**Purpose:** Update code maps and architecture documentation.

**Use When:**
- After significant code changes
- Onboarding new developers
- Architecture reviews
- Documentation updates

**What It Does:**
1. Scans codebase structure
2. Identifies components and modules
3. Maps dependencies
4. Creates/updates architecture diagrams
5. Documents data flows

**Integration:**

```bash
cp optional-components/commands/update-codemaps.md .claude/commands/
```

**Usage:**

```
/update-codemaps
```

**Output:**
- Updated code map documents
- Dependency graphs
- Component diagrams
- Architecture overviews

---

### /update-docs

**Purpose:** Synchronize documentation with code changes using **doc-updater** agent.

**Use When:**
- After API changes
- After feature implementation
- Regular documentation maintenance
- Before releases

**What It Does:**
1. Invokes **doc-updater** agent
2. Compares code to documentation
3. Identifies outdated sections
4. Updates documentation files
5. Maintains consistency

**Integration:**

```bash
# 1. Copy the command
cp optional-components/commands/update-docs.md .claude/commands/

# 2. Ensure doc-updater agent is available
cp optional-components/agents/doc-updater.md .claude/agents/
```

**Usage:**

```
/update-docs
```

**Updates:**
- API documentation
- README files
- Code examples
- Configuration guides

---

## Command Workflows

### Feature Development Workflow

```
/plan → /tdd → /code-review → /test-coverage → /update-docs
```

1. **/plan** - Create implementation plan
2. **/tdd** - Implement with TDD
3. **/code-review** - Review code quality
4. **/test-coverage** - Verify coverage
5. **/update-docs** - Update documentation

### Bug Fix Workflow

```
/tdd → /code-review → /e2e
```

1. **/tdd** - Write failing test + fix
2. **/code-review** - Review fix
3. **/e2e** - Add E2E test if critical

### Maintenance Workflow

```
/refactor-clean → /test-coverage → /update-docs
```

1. **/refactor-clean** - Remove dead code
2. **/test-coverage** - Ensure coverage maintained
3. **/update-docs** - Sync documentation

### Troubleshooting Workflow

```
/build-fix → /code-review
```

1. **/build-fix** - Fix build errors
2. **/code-review** - Verify fix quality

---

## Integration Guide

### Install Single Command

```bash
cp optional-components/commands/tdd.md .claude/commands/
```

**Command is immediately available** - just type `/tdd`

### Install Multiple Commands

For full workflow support:

```bash
# Development workflow
cp optional-components/commands/tdd.md .claude/commands/
cp optional-components/commands/plan.md .claude/commands/
cp optional-components/commands/code-review.md .claude/commands/

# Testing
cp optional-components/commands/e2e.md .claude/commands/
cp optional-components/commands/test-coverage.md .claude/commands/

# Maintenance
cp optional-components/commands/refactor-clean.md .claude/commands/
cp optional-components/commands/update-docs.md .claude/commands/

# Troubleshooting
cp optional-components/commands/build-fix.md .claude/commands/
```

### Install All Commands

```bash
cp optional-components/commands/*.md .claude/commands/
```

---

## Command Dependencies

Some commands require corresponding agents:

| Command | Required Agent |
|---------|---------------|
| /tdd | tdd-guide.md |
| /plan | planner.md |
| /e2e | e2e-runner.md |
| /code-review | code-reviewer.md |
| /build-fix | build-error-resolver.md |
| /refactor-clean | refactor-cleaner.md |
| /update-docs | doc-updater.md |

**Install dependencies:**

```bash
# Example: Installing /tdd and dependencies
cp optional-components/commands/tdd.md .claude/commands/
cp optional-components/agents/tdd-guide.md .claude/agents/
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

---

## Customization

### Modifying Commands

Commands are markdown files with instructions:

```markdown
---
name: command-name
description: Brief description
---

# Command Instructions

Your custom instructions here...
```

**Example - Customizing /tdd:**

```bash
# 1. Copy the command
cp optional-components/commands/tdd.md .claude/commands/

# 2. Edit it
vim .claude/commands/tdd.md

# 3. Customize:
# - Change coverage threshold (80% → 90%)
# - Add project-specific test patterns
# - Modify workflow steps
```

### Creating Custom Commands

```bash
# 1. Create command file
cat > .claude/commands/my-command.md << 'EOF'
---
name: my-command
description: Custom workflow description
---

# My Command

Instructions for Claude to follow...

## Steps
1. First step
2. Second step
3. ...
EOF

# 2. Use it
```

Then type `/my-command` in Claude.

---

## Best Practices

### 1. Use Commands for Workflows

Commands are ideal for multi-step workflows:
- Feature development → /plan, /tdd, /code-review
- Documentation → /dev-docs, /update-docs
- Testing → /e2e, /test-coverage

### 2. Combine with Agents

Most powerful commands invoke agents:
- /plan → planner agent (Opus)
- /code-review → code-reviewer agent
- /tdd → tdd-guide agent

### 3. Create Project-Specific Commands

For repeated workflows unique to your project:

```bash
# Example: Deploy workflow command
cat > .claude/commands/deploy.md << 'EOF'
---
name: deploy
description: Production deployment workflow
---

# Deploy to Production

1. Run /test-coverage - ensure 80%+
2. Run /build-fix - verify build
3. Run /code-review - final review
4. Execute deployment script
5. Verify health checks
6. Update release documentation
EOF
```

### 4. Keep Commands Focused

Each command should have a single clear purpose:
- ✅ /tdd - Test-driven development workflow
- ✅ /code-review - Code review
- ❌ /do-everything - Too broad

---

## Troubleshooting

### Command Not Found

**Problem:** Typing `/command` doesn't work

**Solutions:**
1. **Verify command file exists**: `ls .claude/commands/command-name.md`
2. **Check filename** matches command name
3. **Ensure .md extension** is present
4. **Restart Claude Code** session

### Command Not Working as Expected

**Problem:** Command runs but doesn't do what you expect

**Solutions:**
1. **Check dependencies** - required agents/skills installed?
2. **Review command file** - instructions clear?
3. **Customize command** for your project structure
4. **Provide more context** when invoking

### Agent Not Available

**Problem:** Command requires agent that's not installed

**Solutions:**
1. **Install required agent**: `cp optional-components/agents/agent-name.md .claude/agents/`
2. **Check agent YAML** frontmatter is valid
3. **Verify agent file** is .md format

---

## Command vs Skill vs Agent

**Command (/slash-command):**
- Quick access to workflows
- User-initiated (type `/command`)
- Often orchestrates agents
- Example: `/tdd`, `/plan`, `/code-review`

**Skill:**
- Domain knowledge reference
- Auto-activates based on context
- Provides implementation guidance
- Example: backend-dev-guidelines, frontend-dev-guidelines

**Agent:**
- Autonomous sub-task execution
- Invoked by commands or directly
- Returns result when complete
- Example: planner, code-reviewer, tdd-guide

**Typical Flow:**
```
User types /tdd
  → Command loads tdd.md instructions
    → Command invokes tdd-guide agent
      → Agent uses tdd-workflow skill for guidance
        → Agent implements feature with TDD
          → Agent returns result
```

---

## Integration with Other Components

### Commands + Agents

Commands orchestrate agents:

**Example:**
- `/plan` command invokes **planner** agent
- `/code-review` command invokes **code-reviewer** agent
- `/tdd` command invokes **tdd-guide** agent

### Commands + Skills

Commands may reference skills:

**Example:**
- `/tdd` command → tdd-guide agent → tdd-workflow skill

Skills provide detailed patterns, commands provide workflow structure.

### Commands + Hooks

Commands can be enhanced with hooks:

**Example:**
- `/tdd` command implements TDD
- PostToolUse hook runs tests after code changes
- Stop hook verifies coverage before session end

---

## Learn More

- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Agents:** [../agents/README.md](../agents/README.md)
- **Skills:** [../skills/README.md](../skills/README.md)
- **Main guide:** [../../README.md](../../README.md)
