# Template Setup Guide

**Complete guide to using the Claude Code Multi-Project Starter Template**

This template provides a comprehensive, universal base that works across ALL project types (AI research, web apps, Mac apps, data science, etc.) with optional domain-specific components you can add as needed. Follow this guide to get started quickly.

---

## Table of Contents

1. [Quick Start (5 Minutes)](#quick-start-5-minutes)
2. [Understanding the Structure](#understanding-the-structure)
3. [Essential Setup](#essential-setup)
4. [Adding Domain Skills](#adding-domain-skills)
5. [Customization Guide](#customization-guide)
6. [Optional Enhancements](#optional-enhancements)
7. [Example Integrations](#example-integrations)
8. [Troubleshooting](#troubleshooting)

---

## Quick Start (5 Minutes)

### Option 1: New Project from Scratch

```bash
# 1. Copy the core template to your new project
cp -r /path/to/claude-code-template/.claude/ /path/to/your-project/

# 2. Install hook dependencies
cd /path/to/your-project/.claude/hooks/
npm install

# 3. Test it works
# - Edit any file - the post-tool-use-tracker hook should run
# - Type "skill" in a Claude prompt - skill-developer should auto-suggest
```

**You now have:**
- ✅ Skill auto-activation system working
- ✅ File change tracking
- ✅ Hard rules for security, git, code quality, testing, agents, performance, patterns
- ✅ 12 universal agents ready to use (planning, code quality, security, testing, build, documentation, research)
- ✅ 6 universal commands (/dev-docs, /dev-docs-update, /plan, /code-review, /tdd, /build-fix)
- ✅ 3 universal skills (skill-developer, coding-standards, tdd-workflow)

### Option 2: Add to Existing Project

```bash
# 1. Backup your existing setup (if you have one)
cp -r /path/to/your-project/.claude/ /path/to/your-project/.claude-backup/

# 2. Copy the template
cp -r /path/to/claude-code-template/.claude/ /path/to/your-project/

# 3. Install dependencies
cd /path/to/your-project/.claude/hooks/
npm install

# 4. Merge any custom settings from your backup if needed
```

### Option 3: Use an Example

```bash
# Copy a pre-configured example
cp -r /path/to/claude-code-template/examples/fullstack-typescript/.claude/ /path/to/your-project/

# Install dependencies
cd /path/to/your-project/.claude/hooks/
npm install
```

---

## Understanding the Structure

### Core Template (`.claude/`)

**Universal components that work across all projects:**

```
.claude/
├── settings.json           # Essential hooks configuration
├── hooks/                  # Auto-activation + file tracking (2 essential hooks)
│   ├── skill-activation-prompt.sh/ts
│   ├── post-tool-use-tracker.sh
│   └── package.json
├── skills/                 # 3 universal skills
│   ├── skill-developer/    # Meta-skill for creating skills
│   ├── coding-standards/   # TypeScript best practices
│   ├── tdd-workflow/       # Test-driven development methodology
│   └── skill-rules.json
├── rules/                  # 7 hard rules
│   ├── security.md         # Security guidelines
│   ├── git-workflow.md     # Git and commit standards
│   ├── coding-style.md     # Code quality and style
│   ├── testing.md          # Testing requirements
│   ├── agents.md           # Agent orchestration
│   ├── performance.md      # Performance optimization
│   └── patterns.md         # Common patterns
├── commands/               # 6 universal commands
│   ├── dev-docs.md         # Create dev documentation
│   ├── dev-docs-update.md  # Update dev docs
│   ├── plan.md             # Implementation planning
│   ├── code-review.md      # Comprehensive code review
│   ├── tdd.md              # TDD workflow
│   └── build-fix.md        # Build troubleshooting
└── agents/                 # 12 universal agents
    ├── planner.md          # Four-phase planning
    ├── architect.md        # System design
    ├── plan-reviewer.md    # Plan validation
    ├── code-reviewer.md    # Code review with severity levels
    ├── code-architecture-reviewer.md  # Architectural consistency
    ├── refactor-planner.md            # Refactoring strategies
    ├── code-refactor-master.md        # Execute refactoring
    ├── security-reviewer.md           # Security analysis
    ├── tdd-guide.md                   # TDD enforcement
    ├── build-error-resolver.md        # Build troubleshooting
    ├── documentation-architect.md     # Documentation generation
    └── web-research-specialist.md     # Web research
```

### Optional Components (`optional-components/`)

**Domain-specific components to copy as needed:**

```
optional-components/
├── skills/                 # 9 domain-specific skills (organized by category)
│   ├── backend/
│   │   ├── backend-dev-guidelines/
│   │   ├── backend-patterns/
│   │   └── route-tester/
│   ├── frontend/
│   │   ├── frontend-dev-guidelines/
│   │   └── frontend-patterns/
│   ├── security/
│   │   └── security-review/
│   ├── databases/
│   │   ├── clickhouse-io/
│   │   └── error-tracking/
│   └── project-guidelines-example/
├── agents/                 # 7 specialized agents (organized by category)
│   ├── testing/
│   │   └── e2e-runner.md
│   ├── debugging/
│   │   ├── frontend-error-fixer.md
│   │   ├── auto-error-resolver.md
│   │   └── auth-route-debugger.md
│   ├── maintenance/
│   │   ├── refactor-cleaner.md
│   │   └── doc-updater.md
│   └── domain-specific/
│       └── auth-route-tester.md
├── hooks/                  # Advanced automation (organized by category)
│   ├── validation/
│   ├── automation/
│   └── examples/
├── commands/               # 5 workflow commands (organized by category)
│   ├── testing/
│   ├── workflow/
│   └── research/
└── mcp-configs/            # MCP server examples
```

---

## Essential Setup

### 1. Verify Hook Installation

After copying `.claude/` and running `npm install` in `.claude/hooks/`:

```bash
# Test hooks are executable
ls -la .claude/hooks/*.sh

# Should show -rwxr-xr-x permissions
# If not, run:
chmod +x .claude/hooks/*.sh
```

### 2. Test Skill Auto-Activation

Open Claude Code in your project directory and:

1. Type a message mentioning "skill" or "create skill"
2. The **skill-developer** skill should auto-suggest
3. If it doesn't, see [Troubleshooting](#troubleshooting)

### 3. Verify File Tracking

1. Edit any file in your project
2. The **post-tool-use-tracker** hook should run after the edit
3. Check terminal output for hook execution

### 4. Review Hard Rules

The template includes 7 hard rules in [`.claude/rules/`](.claude/rules/):

- **security.md** - No hardcoded secrets, injection prevention, error tracking
- **git-workflow.md** - Conventional commits, PR reviews
- **coding-style.md** - TypeScript, naming, organization (KISS, DRY, YAGNI)
- **testing.md** - TDD workflow, coverage requirements
- **agents.md** - When to delegate to specialized agents
- **performance.md** - Model selection, context management
- **patterns.md** - API responses, repository patterns, error handling

These guide Claude's behavior across all your work. Review and customize them for your team's standards.

---

## Adding Domain Skills

### Step 1: Choose Skills

**Note:** The base template already includes 3 universal skills (skill-developer, coding-standards, tdd-workflow). Only add domain-specific skills if needed.

Browse [`optional-components/skills/`](optional-components/skills/) and pick what you need:

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

### Step 2: Copy the Skill

```bash
# Example: Adding backend-dev-guidelines
cp -r optional-components/skills/backend/backend-dev-guidelines/ .claude/skills/
```

### Step 3: Add to skill-rules.json

Edit [`.claude/skills/skill-rules.json`](.claude/skills/skill-rules.json) and add the skill configuration.

**Example - Adding backend-dev-guidelines:**

```json
{
  "version": "1.0",
  "description": "Base skill activation triggers. Add project-specific skills as needed.",
  "skills": {
    "skill-developer": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "description": "Meta-skill for creating and managing Claude Code skills",
      "promptTriggers": {
        "keywords": [
          "skill system",
          "create skill",
          "add skill"
        ],
        "intentPatterns": [
          "(how do|how does|explain).*?skill",
          "(create|add|modify|build).*?skill"
        ]
      }
    },
    "backend-dev-guidelines": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "description": "Node.js/Express/Prisma development patterns",
      "promptTriggers": {
        "keywords": [
          "backend",
          "API",
          "route",
          "controller",
          "service",
          "Express",
          "Prisma"
        ],
        "intentPatterns": [
          "(create|add|implement).*?(route|endpoint|API|controller)",
          "(backend|server).*?(development|pattern|guide)"
        ]
      },
      "fileTriggers": {
        "pathPatterns": [
          "backend/**/*.ts",
          "api/**/*.ts",
          "src/routes/**/*.ts",
          "src/controllers/**/*.ts",
          "src/services/**/*.ts"
        ],
        "contentPatterns": [
          "router\\.",
          "export.*Controller",
          "export.*Service"
        ]
      }
    }
  }
}
```

See [`optional-components/skills/README.md`](optional-components/skills/README.md) for pre-made configurations.

### Step 4: Test the Skill

1. Restart Claude Code session (or type a trigger keyword)
2. Mention "backend" or "API" - skill should auto-suggest
3. Edit a file in `backend/` - skill should activate based on file trigger

---

## Customization Guide

### Update Path Patterns for Your Project

Edit [`.claude/skills/skill-rules.json`](.claude/skills/skill-rules.json) to match your project structure:

```json
"fileTriggers": {
  "pathPatterns": [
    "src/server/**/*.ts",      // Your actual backend path
    "apps/api/**/*.ts",         // Monorepo structure
    "packages/backend/**/*.ts"  // Package-based structure
  ]
}
```

### Add Your Domain Keywords

Include terminology specific to your stack:

```json
"keywords": [
  "backend",
  "API",
  "NestJS",              // Your framework
  "PostgreSQL",          // Your database
  "Redis"                // Your cache layer
]
```

### Customize Intent Patterns

Match how your team talks about tasks:

```json
"intentPatterns": [
  "(build|create|make).*?(endpoint|route|handler)",
  "(add|implement).*?(middleware|guard|interceptor)",
  "(fix|debug).*?(API|service|database)"
]
```

### Add Your MCP Servers

Edit [`.claude/settings.json`](.claude/settings.json):

```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "your-custom-mcp-server"
  ]
}
```

See [`optional-components/mcp-configs/README.md`](optional-components/mcp-configs/README.md) for 15 pre-configured examples.

### Customize Rules for Your Team

Edit files in [`.claude/rules/`](.claude/rules/) to match your standards:

```bash
# Example: Update testing requirements
vim .claude/rules/testing.md

# Change minimum coverage from 80% to 90%
# Add your specific testing frameworks
# Include team-specific patterns
```

---

## Optional Enhancements

### Add Specialized Agents

Browse [`optional-components/agents/`](optional-components/agents/) for 13 specialized agents:

**From Original Repository (4 agents):**
- `auth-route-tester.md` - Test authenticated endpoints
- `auth-route-debugger.md` - Debug authentication issues
- `frontend-error-fixer.md` - Debug frontend errors
- `auto-error-resolver.md` - Auto-fix TypeScript errors

**From everything-claude-code (9 agents):**
- `planner.md` - Four-phase feature planning
- `architect.md` - System design decisions
- `tdd-guide.md` - Test-driven development
- `code-reviewer.md` - Code quality review
- `security-reviewer.md` - Vulnerability analysis
- `build-error-resolver.md` - Build troubleshooting
- `e2e-runner.md` - Playwright E2E testing
- `refactor-cleaner.md` - Dead code identification
- `doc-updater.md` - Documentation sync

**To use an agent:**

```bash
cp optional-components/agents/planner.md .claude/agents/
```

No configuration needed - agents are self-contained.

### Add Advanced Hooks

See [`optional-components/hooks/README.md`](optional-components/hooks/README.md) for:

- **TypeScript validation** - Run `tsc --noEmit` after TS file edits
- **Git push approval** - Manual review before push
- **Auto-formatting** - Prettier on save
- **Console.log detection** - Warn about debugging statements
- **TMux enforcement** - Ensure dev servers run in TMux

**Example - Adding TypeScript validation:**

```bash
# 1. Copy the hook
cp optional-components/hooks/tsc-check.sh .claude/hooks/

# 2. Make it executable
chmod +x .claude/hooks/tsc-check.sh

# 3. Add to settings.json
```

Edit [`.claude/settings.json`](.claude/settings.json):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use-tracker.sh"
          }
        ]
      },
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/tsc-check.sh"
          }
        ]
      }
    ]
  }
}
```

### Add Slash Commands

See [`optional-components/commands/README.md`](optional-components/commands/README.md) for 12 commands:

```bash
# Copy commands you need
cp optional-components/commands/tdd.md .claude/commands/
cp optional-components/commands/plan.md .claude/commands/
cp optional-components/commands/code-review.md .claude/commands/
```

Commands auto-activate when you type `/command-name`.

---

## Example Integrations

The template includes 3 pre-configured examples demonstrating different project types:

### Full-Stack TypeScript

**Path:** [`examples/fullstack-typescript/`](examples/fullstack-typescript/)

**Includes:**
- backend-dev-guidelines skill
- frontend-dev-guidelines skill
- error-tracking skill (Sentry)
- route-tester skill
- All 7 hard rules active

**Use for:** Web applications with Node.js backend + React frontend

```bash
cp -r examples/fullstack-typescript/.claude/ my-fullstack-app/
cd my-fullstack-app/.claude/hooks/
npm install
```

### Backend-Only API

**Path:** [`examples/backend-only/`](examples/backend-only/)

**Includes:**
- backend-dev-guidelines skill
- error-tracking skill (Sentry)
- route-tester skill
- Security and git-workflow rules active

**Use for:** REST APIs, GraphQL servers, microservices

```bash
cp -r examples/backend-only/.claude/ my-api/
cd my-api/.claude/hooks/
npm install
```

### Frontend-Only Application

**Path:** [`examples/frontend-only/`](examples/frontend-only/)

**Includes:**
- frontend-dev-guidelines skill
- Security and coding-standards rules active

**Use for:** React apps, SPAs, static sites

```bash
cp -r examples/frontend-only/.claude/ my-frontend-app/
cd my-frontend-app/.claude/hooks/
npm install
```

---

## Troubleshooting

### Skill Not Auto-Suggesting

**Problem:** Skill doesn't suggest when you mention trigger keywords

**Solutions:**

1. **Check skill-rules.json configuration**
   ```bash
   cat .claude/skills/skill-rules.json
   ```
   Verify the skill is configured with trigger keywords

2. **Verify hook is registered**
   ```bash
   cat .claude/settings.json | grep UserPromptSubmit
   ```
   Should show skill-activation-prompt.sh

3. **Test hook manually**
   ```bash
   .claude/hooks/skill-activation-prompt.sh
   ```
   Should run without errors

4. **Check npm dependencies**
   ```bash
   cd .claude/hooks/
   npm install
   ```

5. **Restart Claude Code session**
   Exit and re-enter the project directory

### Hook Not Running

**Problem:** post-tool-use-tracker or other hooks don't execute

**Solutions:**

1. **Check hooks are executable**
   ```bash
   ls -la .claude/hooks/*.sh
   ```
   Should show -rwxr-xr-x permissions

   ```bash
   chmod +x .claude/hooks/*.sh
   ```

2. **Verify settings.json configuration**
   ```bash
   cat .claude/settings.json | grep -A 10 hooks
   ```

3. **Test hook directly**
   ```bash
   .claude/hooks/post-tool-use-tracker.sh
   ```

4. **Check for errors in terminal output**
   Look for hook execution messages after editing files

### File Triggers Not Working

**Problem:** Skills don't activate when editing matching files

**Solutions:**

1. **Update path patterns** in skill-rules.json to match your structure:
   ```json
   "pathPatterns": [
     "src/**/*.ts",      // Check your actual paths
     "backend/**/*.ts"
   ]
   ```

2. **Check file is in tracked location**
   ```bash
   pwd  # Verify you're in project root
   ```

3. **Restart session** after modifying skill-rules.json

### Context Limit Issues

**Problem:** Skills loading too much context

**Solutions:**

1. **Use modular skill pattern** - Break large skills into resources
2. **Reference specific resources** - Load only what you need
3. **Keep SKILL.md under 500 lines** - Use progressive disclosure

See [`.claude/skills/skill-developer/`](.claude/skills/skill-developer/) for modular pattern example.

### Dependencies Not Installing

**Problem:** `npm install` fails in `.claude/hooks/`

**Solutions:**

1. **Check Node.js version**
   ```bash
   node --version  # Should be v20+
   ```

2. **Clear npm cache**
   ```bash
   cd .claude/hooks/
   rm -rf node_modules package-lock.json
   npm cache clean --force
   npm install
   ```

3. **Check package.json exists**
   ```bash
   cat .claude/hooks/package.json
   ```

### Rules Not Being Followed

**Problem:** Claude isn't following rules in `.claude/rules/`

**Note:** Rules are guidelines, not strict enforcement. For strict enforcement:

1. Use **skill enforcement levels** in skill-rules.json:
   ```json
   "enforcement": "block"  // Requires skill use before proceeding
   ```

2. Use **PreToolUse hooks** to validate before actions

3. Use **code-reviewer agent** after writing code to verify compliance

### Getting More Help

1. **Check component READMEs:**
   - [`.claude/rules/README.md`](.claude/rules/README.md)
   - [`.claude/hooks/README.md`](.claude/hooks/README.md)
   - [`.claude/skills/README.md`](.claude/skills/README.md)
   - [`.claude/agents/README.md`](.claude/agents/README.md)
   - [`optional-components/skills/README.md`](optional-components/skills/README.md)
   - [`optional-components/agents/README.md`](optional-components/agents/README.md)

2. **Review examples:**
   - [`examples/fullstack-typescript/`](examples/fullstack-typescript/)
   - [`examples/backend-only/`](examples/backend-only/)
   - [`examples/frontend-only/`](examples/frontend-only/)

3. **Open an issue** with:
   - Your project structure
   - What you're trying to achieve
   - Error messages or unexpected behavior

---

## Next Steps

1. ✅ Complete essential setup
2. ✅ Add domain skills for your tech stack
3. ✅ Customize path patterns and keywords
4. ✅ Test skill auto-activation works
5. ⚙️ Add optional components as needed
6. 🚀 Start building with Claude Code!

---

**Need more help?** See the [main README](README.md) for additional resources and documentation links.
