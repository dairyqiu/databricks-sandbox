# Claude Code Multi-Project Starter Template

**A comprehensive, production-tested template for launching new projects with Claude Code.**

Start with a powerful base of universal components that work across ALL project types (AI research, web apps, Mac apps, data science, etc.), then selectively add domain-specific components as needed. Born from 6 months of real-world development and enriched with battle-tested patterns from the Claude Code community.

---

## What's Inside

### 🎯 Core Template (`.claude/`)
**Comprehensive base that works across ALL project types:**

**12 Universal Agents:**
- Planning & Architecture: planner, architect, plan-reviewer
- Code Quality: code-reviewer, code-architecture-reviewer, refactor-planner, code-refactor-master
- Security & Testing: security-reviewer, tdd-guide
- Build & Documentation: build-error-resolver, documentation-architect
- Research: web-research-specialist

**9 Universal Commands:**
- `/dev-docs` - Create development documentation
- `/dev-docs-update` - Update dev docs before context reset
- `/code-review` - Comprehensive code review
- `/tdd` - Test-driven development workflow
- `/build-fix` - Build error troubleshooting
- `/ralph-dev` - Start autonomous loop with dev-docs persistence
- `/ralph-status` - Show Ralph loop status and metrics
- `/ralph-resume` - Resume paused or crashed Ralph loop

**Note:** Planning now uses Claude Code's built-in plan mode (EnterPlanMode) instead of a custom command.

**3 Universal Skills:**
- skill-developer - Meta-skill for creating skills
- coding-standards - TypeScript best practices
- tdd-workflow - Test-driven development methodology

**7 Hard Rules:**
- Security, git workflow, code quality, testing, agents, performance, patterns

**Essential Hooks:**
- Skill auto-activation + file change tracking
- Ralph autonomous loop (Stop hook for loop continuation)
- Ralph safety hooks (iteration guard, stuck detection, quality gates, context sync)

### 📦 Optional Components (`optional-components/`)
**Add only what your specific project needs:**
- **9 domain skills** - Backend, frontend, security, databases (organized by category)
- **7 specialized agents** - E2E testing, debugging, maintenance (organized by category)
- **5 workflow commands** - Testing, workflow automation, research
- **Advanced hooks** - TypeScript validation, auto-formatting, console.log detection
- **MCP configurations** - 15 pre-configured MCP servers

### 📚 Examples (`examples/`)
**See it in action:**
- Full-stack TypeScript setup
- Backend-only API project
- Frontend-only app

---

## Quick Start

### Option 1: Start Fresh (5 minutes)

```bash
# 1. Copy the core template to your new project
cp -r .claude/ /path/to/your-project/

# 2. Install hook dependencies
cd /path/to/your-project/.claude/hooks/
npm install

# 3. Test it works
# Edit any file - the post-tool-use-tracker hook should run
# Type "skill" in a prompt - skill-developer should auto-suggest
```

You now have:
- ✅ Skill auto-activation system working
- ✅ File change tracking
- ✅ Hard rules for security, git, code quality, testing, agents, performance, patterns
- ✅ 12 universal agents ready to use (planning, code quality, security, testing, build, documentation, research)
- ✅ 9 universal commands (/dev-docs, /dev-docs-update, /code-review, /tdd, /build-fix, /ralph-dev, /ralph-status, /ralph-resume)
- ✅ 3 universal skills (skill-developer, coding-standards, tdd-workflow)
- ✅ Ralph autonomous loop plugin with safety mechanisms

### Option 2: Add to Existing Project (10 minutes)

If you already have a `.claude/` directory:

```bash
# 1. Backup your existing setup
cp -r .claude/ .claude-backup/

# 2. Copy hooks
cp -r .claude/hooks/* /path/to/your-project/.claude/hooks/

# 3. Copy or merge settings.json
# Review .claude/settings.json and integrate hooks config

# 4. Copy rules
cp -r .claude/rules/ /path/to/your-project/.claude/

# 5. Install dependencies
cd /path/to/your-project/.claude/hooks/
npm install
```

### Option 3: Use an Example (2 minutes)

```bash
# Copy a pre-configured example
cp -r examples/fullstack-typescript/.claude/ /path/to/your-project/

# Install dependencies
cd /path/to/your-project/.claude/hooks/
npm install
```

---

## Adding Optional Components

### Domain Skills

Browse [`optional-components/skills/`](optional-components/skills/) and copy what you need:

**Note:** coding-standards and tdd-workflow are now in the base template. The remaining 9 domain-specific skills are organized by category:

**Backend Development:**
- `backend/backend-dev-guidelines/` - Node.js/Express/Prisma patterns
- `backend/backend-patterns/` - API design, caching, queuing
- `backend/route-tester/` - API route testing with JWT auth

**Frontend Development:**
- `frontend/frontend-dev-guidelines/` - React/MUI v7 patterns
- `frontend/frontend-patterns/` - React composition, hooks, performance

**Security:**
- `security/security-review/` - Security checklist

**Databases:**
- `databases/clickhouse-io/` - Analytics queries
- `databases/error-tracking/` - Sentry integration

**Templates:**
- `project-guidelines-example/` - Template for creating your own skills

**To integrate a skill:**

```bash
# 1. Copy the skill
cp -r optional-components/skills/backend/backend-dev-guidelines/ .claude/skills/

# 2. Add to skill-rules.json
# Copy the skill configuration from optional-components/skills/README.md
# and add it to .claude/skills/skill-rules.json
```

### Specialized Agents

**Note:** 6 universal agents (planner, code-reviewer, security-reviewer, architect, tdd-guide, build-error-resolver) are now in the base template.

See [`optional-components/agents/README.md`](optional-components/agents/README.md) for 7 remaining specialized agents organized by category:

**Testing:**
- `testing/e2e-runner.md` - Playwright E2E test execution

**Debugging:**
- `debugging/frontend-error-fixer.md` - Debug frontend build and runtime errors
- `debugging/auto-error-resolver.md` - Auto-fix TypeScript compilation errors
- `debugging/auth-route-debugger.md` - Debug JWT authentication issues

**Maintenance:**
- `maintenance/refactor-cleaner.md` - Dead code identification and removal
- `maintenance/doc-updater.md` - Documentation synchronization with code

**Domain-Specific:**
- `domain-specific/auth-route-tester.md` - Test authenticated endpoints (JWT cookie auth)

**To use an agent:**
```bash
cp optional-components/agents/testing/e2e-runner.md .claude/agents/
```

### Advanced Hooks

See [`optional-components/hooks/README.md`](optional-components/hooks/README.md) for:

- TypeScript validation on save
- Git push approval gates
- Auto-formatting with Prettier
- Console.log detection
- And more...

### Slash Commands

**Base Commands (included in core template):**

See [`.claude/commands/README.md`](.claude/commands/README.md) for all 6 universal commands:
- `/dev-docs` - Create development documentation for tracking features
- `/dev-docs-update` - Update dev docs before context reset
- `/plan` - Four-phase implementation planning
- `/code-review` - Comprehensive code review
- `/tdd` - Test-driven development workflow
- `/build-fix` - Build error troubleshooting

**Optional Commands:**

**Note:** The 4 most universal commands (plan, code-review, tdd, build-fix) are now in the base template.

See [`optional-components/commands/README.md`](optional-components/commands/README.md) for 5 remaining workflow commands organized by category:

**Testing:**
- `/e2e` - End-to-end testing with Playwright
- `/test-coverage` - Analyze test coverage

**Workflow:**
- `/refactor-clean` - Dead code identification
- `/update-docs` - Documentation synchronization

**Research:**
- `/route-research` - Research API routes for testing

---

## How It Works

### Auto-Activation System

The core of this template is the skill auto-activation system:

1. **UserPromptSubmit Hook** - Runs before Claude sees your prompt
2. **skill-rules.json** - Defines trigger patterns (keywords, intent, file paths)
3. **Skill Suggestions** - Skills automatically suggest when relevant
4. **Progressive Disclosure** - Resources load only when needed

**Result:** Skills activate based on context, not memory.

### Hard Rules System

Located in [`.claude/rules/`](.claude/rules/), these enforce critical practices:

- **security.md** - No hardcoded secrets, injection prevention, error tracking
- **git-workflow.md** - Conventional commits, PR reviews
- **coding-style.md** - TypeScript, naming, organization (KISS, DRY, YAGNI)
- **testing.md** - TDD workflow, coverage requirements
- **agents.md** - When to delegate to specialized agents
- **performance.md** - Model selection, context management
- **patterns.md** - API responses, repository patterns, error handling

These rules guide Claude's behavior across all your projects.

### Ralph Autonomous Loop Plugin

The template includes the Ralph Wiggum plugin for autonomous coding loops:

**What It Does:**
- Automatically continues work across multiple turns without user input
- Persists context for crash recovery via dev-docs integration
- Includes safety safeguards: max iterations, runtime limits, stuck detection

**Commands:**
- `/ralph-dev "<task>"` - Start loop with full persistence (recommended)
- `/ralph-status` - Check loop progress and metrics
- `/ralph-resume` - Resume from paused or crashed state

**Example:**
```bash
/ralph-dev "Build a REST API with authentication and tests"
```

**Safety Mechanisms:**
- Max iterations (default: 50)
- Runtime limit (default: 4 hours)
- Stuck detection (3 identical failures)
- Idle timeout (no file changes for 5 iterations)
- Quality gates (tests/lint each iteration)

See [.claude/plugins/ralph-wiggum/README.md](.claude/plugins/ralph-wiggum/README.md) for full documentation.

### Modular Skills (500-Line Rule)

Large skills hit context limits. This template uses modular structure:

```
skill-name/
  SKILL.md                  # <500 lines - Overview + navigation
  resources/
    topic-1.md              # <500 lines each
    topic-2.md
```

Claude loads the main file first, then resources only when explicitly referenced.

---

## Repository Structure

```
claude-code-template/
├── .claude/                    # CORE TEMPLATE (copy this)
│   ├── settings.json           # Essential hooks configuration
│   ├── hooks/                  # Auto-activation, file tracking, Ralph safety hooks
│   ├── skills/                 # 3 universal skills (skill-developer, coding-standards, tdd-workflow)
│   ├── rules/                  # 7 hard rules (security, git, code quality, testing, agents, performance, patterns)
│   ├── agents/                 # 12 universal agents (planning, code quality, security, testing, build, docs, research)
│   ├── commands/               # 9 universal commands (dev-docs, code-review, tdd, build-fix, ralph-*)
│   └── plugins/                # Plugins (ralph-wiggum autonomous loop)
│
├── optional-components/        # Add only what you need
│   ├── skills/                 # 9 domain-specific skills (organized by category)
│   │   ├── backend/            # backend-dev-guidelines, backend-patterns, route-tester
│   │   ├── frontend/           # frontend-dev-guidelines, frontend-patterns
│   │   ├── security/           # security-review
│   │   ├── databases/          # clickhouse-io, error-tracking
│   │   └── project-guidelines-example/
│   ├── agents/                 # 7 specialized agents (organized by category)
│   │   ├── testing/            # e2e-runner
│   │   ├── debugging/          # frontend-error-fixer, auto-error-resolver, auth-route-debugger
│   │   ├── maintenance/        # refactor-cleaner, doc-updater
│   │   └── domain-specific/    # auth-route-tester
│   ├── hooks/                  # Advanced automation hooks
│   │   ├── validation/         # tsc-check, stop-build-check-enhanced
│   │   ├── automation/         # trigger-build-resolver, error-handling-reminder
│   │   └── examples/           # hooks.json
│   ├── commands/               # 5 workflow commands (organized by category)
│   │   ├── testing/            # e2e, test-coverage
│   │   ├── workflow/           # refactor-clean, update-docs
│   │   └── research/           # route-research
│   └── mcp-configs/            # MCP server examples
│
├── examples/                   # Pre-configured setups
│   ├── fullstack-typescript/
│   ├── backend-only/
│   └── frontend-only/
│
├── legacy-components/          # Archived original files
├── everything-claude-code/     # Source materials (reference)
└── dev/                        # Dev docs pattern
```

---

## Documentation

- **[TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md)** - Comprehensive setup guide
- **[.claude/rules/README.md](.claude/rules/README.md)** - Hard rules explanation
- **[.claude/hooks/README.md](.claude/hooks/README.md)** - Essential hooks guide
- **[.claude/skills/README.md](.claude/skills/README.md)** - Minimal base skills
- **[.claude/agents/README.md](.claude/agents/README.md)** - Universal agents
- **[optional-components/skills/README.md](optional-components/skills/README.md)** - Optional skills catalog
- **[optional-components/agents/README.md](optional-components/agents/README.md)** - Specialized agents
- **[optional-components/hooks/README.md](optional-components/hooks/README.md)** - Advanced hooks
- **[optional-components/commands/README.md](optional-components/commands/README.md)** - Slash commands

---

## Philosophy

### Comprehensive Base, Domain Specifics Only When Needed

The base template is comprehensive and universal:
- **12 universal agents** covering planning, code quality, security, testing, build, documentation, and research
- **6 universal commands** for essential workflows (dev docs, planning, code review, TDD, build troubleshooting)
- **3 universal skills** providing coding standards and TDD methodology
- **7 hard rules** for critical areas (security, git, code quality, testing, agents, performance, patterns)
- **Essential automation** (skill activation + file tracking)

**Philosophy Shift:** From "minimal base, choose your tools" to "comprehensive base, add domain specifics only"

**Result:** Works for most project types (AI research, web apps, Mac apps, data science) without any additions.

Add domain-specific components only when needed:
- Backend/frontend framework patterns
- Advanced validation hooks
- Specialized debugging agents

### Production-Tested

This template combines:
- **6 months** of microservices development patterns (original repo)
- **10+ months** of intensive Claude Code use (everything-claude-code)
- **Real-world** testing across multiple applications
- **Community** best practices

### Flexible & Adaptable

- Works with any tech stack
- Copy entire `.claude/` or cherry-pick components
- Customize rules and skills for your team
- Examples show different integration approaches

---

## What Makes This Special

### 1. It Actually Works Out of the Box

Unlike many templates, this is:
- ✅ Tested in production
- ✅ Minimal dependencies
- ✅ Clear documentation
- ✅ Working examples

### 2. Solves the Skills Problem

Skills are powerful but often sit unused. This template:
- ✅ Auto-suggests skills based on context
- ✅ Tracks file changes for smarter suggestions
- ✅ Uses progressive disclosure to avoid context limits

### 3. Comprehensive Component Library

**Base Template:**
- 12 universal agents
- 9 universal commands (including Ralph loop)
- 3 universal skills
- 7 hard rules
- Essential hooks (activation + Ralph safety)
- Ralph autonomous loop plugin

**Optional Components:**
- 9 domain skills
- 7 specialized agents
- 5 workflow commands
- Advanced automation hooks
- 15 MCP configurations

Most projects need only the base. Add optionals for specific tech stacks.

### 4. Multi-Project Ready

Designed as a starter template, not a one-off showcase:
- Clear separation: universal vs. domain-specific
- Examples for different project types
- Easy to copy and customize

---

## Common Use Cases

### Starting a New Full-Stack Project

```bash
cp -r examples/fullstack-typescript/.claude/ my-project/
cd my-project/.claude/hooks/
npm install
```

Includes: backend-dev-guidelines, frontend-dev-guidelines, error-tracking, route-tester

### Adding Claude Code to Existing Backend

```bash
# Base template already includes planning, code review, TDD, and build troubleshooting
cp -r .claude/ my-api/

# Add backend-specific patterns if needed
cp -r optional-components/skills/backend/backend-dev-guidelines/ my-api/.claude/skills/
# Update skill-rules.json with backend-dev-guidelines config

cd my-api/.claude/hooks/
npm install
```

### Team Standardization

```bash
# Fork this template
# Customize .claude/rules/ for your team standards
# Add your tech stack skills to .claude/skills/
# Distribute to team members
```

---

## Credits & Sources

This template combines components from two sources:

### Original Repository
- 6 months of TypeScript microservices development
- Auto-activation system (hooks + skill-rules.json)
- Modular skill pattern (500-line rule)
- Backend/frontend dev guidelines
- Route tester, error tracking skills
- Code architecture and refactoring agents

### everything-claude-code (by @affaan-m)
- 10+ months of intensive Claude Code use
- Hard rules system (security, git, coding, testing, agents, performance, patterns)
- TDD workflow and coding standards
- Planning, architecture, security, and build troubleshooting agents
- Advanced hooks (git gates, auto-formatting)
- MCP configurations

### Consolidation
- Moved 6 universal agents to base (planner, code-reviewer, security-reviewer, architect, tdd-guide, build-error-resolver)
- Moved 4 universal commands to base (plan, code-review, tdd, build-fix)
- Moved 2 universal skills to base (coding-standards, tdd-workflow)
- Organized optional components by category for easy discovery

---

## License

MIT License - Use freely in your projects, commercial or personal.

---

## Getting Help

**Issues with setup?**
- Check [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md)
- Review [examples/](examples/) for working configurations
- Open an issue with your project structure

**Want to contribute?**
- Add your own skills to optional-components/
- Share example integrations
- Improve documentation
- Report bugs

---

## Quick Reference

**Essential Files:**
- [`.claude/settings.json`](.claude/settings.json) - Hook configuration
- [`.claude/skills/skill-rules.json`](.claude/skills/skill-rules.json) - Skill triggers
- [`.claude/rules/`](.claude/rules/) - Hard rules

**Key Directories:**
- [`.claude/`](.claude/) - Core template (copy this)
- [`optional-components/`](optional-components/) - Additional components
- [`examples/`](examples/) - Working examples
- [`legacy-components/`](legacy-components/) - Archived originals

**Documentation:**
- [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md) - Full setup guide
- [.claude/hooks/README.md](.claude/hooks/README.md) - Hooks explained
- [optional-components/skills/README.md](optional-components/skills/README.md) - Skills catalog

---

**Ready to start?** Copy [`.claude/`](.claude/) to your project and run `npm install` in `.claude/hooks/`
