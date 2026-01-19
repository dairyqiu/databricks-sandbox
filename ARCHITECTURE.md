# Architecture & Design Principles

**Design philosophy and technical architecture of the Claude Code Multi-Project Starter Template**

This document explains the consolidation strategy, classification methodology, and system architecture that make this template comprehensive and universal.

---

## Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Universal vs Domain-Specific Classification](#universal-vs-domain-specific-classification)
3. [Base Template Composition](#base-template-composition)
4. [Optional Components Organization](#optional-components-organization)
5. [Skill Auto-Activation System](#skill-auto-activation-system)
6. [Agent System](#agent-system)
7. [Hard Rules System](#hard-rules-system)
8. [Hooks Architecture](#hooks-architecture)
9. [Progressive Disclosure Pattern](#progressive-disclosure-pattern)
10. [Multi-Project Template Philosophy](#multi-project-template-philosophy)

---

## Design Philosophy

### Philosophy Shift: Comprehensive Base → Domain Specifics Only

**Previous Approach:** "Minimal base, choose your tools"
- Small base with only essential components
- Users must discover and add most components
- Risk of inconsistent setups across projects

**Current Approach:** "Comprehensive base, add domain specifics only"
- Powerful base with 12 universal agents, 6 commands, 3 skills
- Works for most project types (AI research, web apps, Mac apps, data science) without additions
- Domain-specific components (backend/frontend frameworks) added only when needed

**Result:**
- **100% increase** in base agents (6 → 12)
- **200% increase** in base commands (2 → 6)
- **200% increase** in base skills (1 → 3)
- **46% reduction** in optional agents (13 → 7)
- **18% reduction** in optional skills (11 → 9)

### Core Principles

1. **Universal by Default** - Base template works across ALL project types
2. **Domain-Specific on Demand** - Add framework patterns only when needed
3. **Organized for Discovery** - Categorized structure makes finding components easy
4. **Production-Tested** - All components battle-tested in real projects
5. **Progressive Disclosure** - Load resources only when needed (500-line rule)

---

## Universal vs Domain-Specific Classification

### Classification Criteria

**Universal Components** (belong in base template):
- ✅ Apply to ALL project types (AI research, web apps, native apps, data science)
- ✅ Language/framework agnostic
- ✅ Represent essential workflows (planning, code review, testing, security)
- ✅ No assumptions about tech stack

**Domain-Specific Components** (belong in optional-components):
- ❌ Tied to specific frameworks (Express, React, Playwright)
- ❌ Language/tool-specific (TypeScript-only, JWT-specific)
- ❌ Optional workflows (E2E testing, Sentry integration)
- ❌ Make assumptions about project structure

### Classification Examples

#### Agents

**Universal (moved to base):**
- **planner** - Four-phase planning applies to any codebase
- **code-reviewer** - Code quality review is universal
- **security-reviewer** - Security applies to all projects
- **architect** - System design decisions are universal
- **tdd-guide** - Testing methodology applies everywhere
- **build-error-resolver** - All projects have builds that can fail

**Domain-Specific (remains optional):**
- **e2e-runner** - Playwright-specific (testing category)
- **frontend-error-fixer** - React/frontend-specific (debugging category)
- **auth-route-tester** - JWT/Express-specific (domain-specific category)

#### Skills

**Universal (moved to base):**
- **coding-standards** - TypeScript best practices apply broadly
- **tdd-workflow** - Test-driven development methodology is universal

**Domain-Specific (remains optional):**
- **backend-dev-guidelines** - Express/Prisma specific (backend category)
- **frontend-dev-guidelines** - React/MUI specific (frontend category)
- **error-tracking** - Sentry-specific (databases category)

#### Commands

**Universal (moved to base):**
- **/plan** - Implementation planning is universal
- **/code-review** - Code review applies everywhere
- **/tdd** - TDD workflow applies everywhere
- **/build-fix** - Build troubleshooting is universal

**Domain-Specific (remains optional):**
- **/e2e** - Playwright E2E testing (testing category)
- **/route-research** - API-specific research (research category)

---

## Base Template Composition

### Complete Inventory

**12 Universal Agents:**

*Planning & Architecture (3):*
1. planner - Four-phase implementation planning (Opus model)
2. architect - System design and architectural decisions
3. plan-reviewer - Review plans before implementation

*Code Quality (4):*
4. code-reviewer - Comprehensive code review with severity levels
5. code-architecture-reviewer - Architectural consistency review
6. refactor-planner - Create detailed refactoring strategies
7. code-refactor-master - Plan and execute refactoring

*Security & Testing (2):*
8. security-reviewer - Security vulnerability analysis (OWASP Top 10)
9. tdd-guide - Test-driven development enforcement

*Build & Documentation (2):*
10. build-error-resolver - Build and compilation error troubleshooting
11. documentation-architect - Generate comprehensive documentation

*Research (1):*
12. web-research-specialist - Research technical issues online

**6 Universal Commands:**
1. `/dev-docs` - Create development documentation
2. `/dev-docs-update` - Update dev docs before context reset
3. `/plan` - Four-phase implementation planning (invokes planner agent)
4. `/code-review` - Comprehensive code review (invokes code-reviewer agent)
5. `/tdd` - Test-driven development workflow (invokes tdd-guide agent)
6. `/build-fix` - Build error troubleshooting (invokes build-error-resolver agent)

**3 Universal Skills:**
1. **skill-developer** - Meta-skill for creating and managing skills
2. **coding-standards** - TypeScript coding standards and best practices
3. **tdd-workflow** - Test-driven development methodology with 80% coverage

**7 Hard Rules:**
1. **security.md** - Security guidelines (no secrets, input validation, injection prevention)
2. **git-workflow.md** - Git and commit standards (conventional commits, PR workflow)
3. **coding-style.md** - Code quality and style (immutability, file organization, error handling)
4. **testing.md** - Testing requirements (80% coverage, TDD workflow)
5. **agents.md** - Agent orchestration (when to use which agent, parallel execution)
6. **performance.md** - Performance optimization (model selection, context management)
7. **patterns.md** - Common patterns (API responses, repository pattern, hooks)

**2 Essential Hooks:**
1. **skill-activation-prompt** - Auto-suggests skills based on context
2. **post-tool-use-tracker** - Tracks file changes for smarter skill suggestions

### Why These Components Are Universal

**Agents:**
- Planning, code quality, security, testing, build troubleshooting, and documentation apply to ALL codebases
- No assumptions about language, framework, or project type
- Essential workflows for professional development

**Commands:**
- Dev docs pattern works for any project needing context management
- Planning, code review, TDD, and build troubleshooting are universal workflows
- Simple orchestration of universal agents

**Skills:**
- Coding standards transcend specific frameworks
- TDD methodology applies regardless of language
- skill-developer enables creating project-specific skills

**Rules:**
- Security, git workflow, code quality, and testing are critical everywhere
- Performance and patterns provide general guidance
- Agent orchestration ensures efficient workflows

**Hooks:**
- Skill activation works across all project types
- File change tracking is universally useful
- No heavy automation that might conflict with project-specific setups

---

## Optional Components Organization

### Categorical Structure

**Design Goal:** Make domain-specific components easy to find and integrate.

#### Agents (7 specialized agents)

```
optional-components/agents/
├── testing/
│   └── e2e-runner.md              # Playwright E2E test execution
├── debugging/
│   ├── frontend-error-fixer.md    # Debug frontend build/runtime errors
│   ├── auto-error-resolver.md     # Auto-fix TypeScript errors
│   └── auth-route-debugger.md     # Debug JWT authentication
├── maintenance/
│   ├── refactor-cleaner.md        # Dead code identification
│   └── doc-updater.md             # Documentation synchronization
└── domain-specific/
    └── auth-route-tester.md       # Test JWT authenticated endpoints
```

**Categories:**
- **testing/** - Testing framework integrations
- **debugging/** - Stack-specific debugging tools
- **maintenance/** - Code cleanup and documentation
- **domain-specific/** - Project-type-specific agents

#### Skills (9 domain-specific skills)

```
optional-components/skills/
├── backend/
│   ├── backend-dev-guidelines/    # Node.js/Express/Prisma patterns
│   ├── backend-patterns/          # API design, caching, queuing
│   └── route-tester/              # API route testing with JWT auth
├── frontend/
│   ├── frontend-dev-guidelines/   # React/MUI v7 patterns
│   └── frontend-patterns/         # React composition, hooks, performance
├── security/
│   └── security-review/           # Security checklist
├── databases/
│   ├── clickhouse-io/             # Analytics queries
│   └── error-tracking/            # Sentry integration
└── project-guidelines-example/     # Template for custom skills
```

**Categories:**
- **backend/** - Backend framework patterns
- **frontend/** - Frontend framework patterns
- **security/** - Security-specific patterns
- **databases/** - Database and monitoring tools

#### Commands (5 workflow commands)

```
optional-components/commands/
├── testing/
│   ├── e2e.md                     # End-to-end testing with Playwright
│   └── test-coverage.md           # Analyze test coverage
├── workflow/
│   ├── refactor-clean.md          # Dead code identification
│   └── update-docs.md             # Documentation synchronization
└── research/
    └── route-research.md          # Research API routes for testing
```

**Categories:**
- **testing/** - Testing workflow commands
- **workflow/** - Maintenance and cleanup workflows
- **research/** - Investigation and analysis commands

#### Hooks (4 advanced hooks)

```
optional-components/hooks/
├── validation/
│   ├── tsc-check.sh               # TypeScript validation on save
│   └── stop-build-check-enhanced.sh  # Build validation gates
├── automation/
│   ├── trigger-build-resolver.sh  # Auto-trigger build fixes
│   └── error-handling-reminder.sh # Remind about error handling
└── examples/
    └── hooks.json                 # Example hook configurations
```

**Categories:**
- **validation/** - Pre/post checks for quality gates
- **automation/** - Automatic fixes and reminders
- **examples/** - Reference configurations

---

## Skill Auto-Activation System

### Architecture Overview

```
User Prompt
    ↓
UserPromptSubmit Hook (skill-activation-prompt)
    ↓
Reads: skill-rules.json
    ↓
Matches triggers:
  - Keywords in prompt
  - Intent patterns (regex)
  - File paths being edited
  - Content patterns in files
    ↓
Generates skill suggestions
    ↓
Claude sees: <skill-suggestions>...</skill-suggestions>
    ↓
Claude decides whether to use skill
```

### skill-rules.json Structure

```json
{
  "version": "1.0",
  "description": "Base skill activation triggers",
  "skills": {
    "skill-name": {
      "type": "domain|methodology|quality",
      "enforcement": "suggest|block|warn",
      "priority": "critical|high|medium|low",
      "description": "What this skill does",
      "promptTriggers": {
        "keywords": ["word1", "word2"],
        "intentPatterns": ["regex1", "regex2"]
      },
      "fileTriggers": {
        "pathPatterns": ["**/*.ts", "src/**"],
        "contentPatterns": ["class\\s+\\w+", "export.*Controller"]
      }
    }
  }
}
```

### Trigger Types

**1. Keyword Triggers**
- Match exact words in user prompts
- Example: "backend", "API", "route" → backend-dev-guidelines

**2. Intent Pattern Triggers**
- Match regex patterns indicating user intent
- Example: `"(create|add).*?(route|endpoint)"` → backend-dev-guidelines

**3. File Path Triggers**
- Match glob patterns for files being edited
- Example: `"backend/**/*.ts"` → backend-dev-guidelines

**4. Content Pattern Triggers**
- Match regex patterns in file contents
- Example: `"router\\."` → backend-dev-guidelines

### Enforcement Levels

- **suggest** - Skill appears in suggestions, user can ignore
- **block** - Requires skill to be used before proceeding (guardrail)
- **warn** - Shows warning but allows proceeding

### Priority Levels

- **critical** - Always trigger when matched
- **high** - Trigger for most matches
- **medium** - Trigger for clear matches
- **low** - Trigger only for explicit matches

---

## Agent System

### Agent Architecture

**What is an Agent?**
- Autonomous markdown-based task executor
- YAML frontmatter configuration
- Access to tools (Read, Edit, Bash, WebSearch, etc.)
- Can launch sub-agents for complex tasks

**Agent Structure:**
```markdown
---
name: agent-name
description: What this agent does
tools: [Read, Edit, Bash, Grep, Glob]
model: sonnet|opus|haiku
color: green
---

# Agent Instructions

Detailed instructions for how this agent should work...
```

### Agent Invocation

**Automatic (Proactive):**
- Claude invokes agents based on task requirements
- Example: Complex feature request → planner agent
- Example: Code just written → code-reviewer agent

**Explicit (User Request):**
```
User: "Use the planner agent to plan authentication implementation"
```

**Via Commands:**
```
/plan add user authentication
```
→ Invokes planner agent

### Agent Workflow

```
Main Claude Instance
    ↓
Task delegation decision
    ↓
Launch Agent (Task tool)
    ↓
Agent runs autonomously:
  - Explores codebase
  - Makes decisions
  - Uses tools
  - May launch sub-agents
    ↓
Agent completes and returns result
    ↓
Main Claude incorporates result
```

### Parallel Agent Execution

Agents can run in parallel for independent tasks:

```
Main Claude launches 3 agents in parallel:
  ├─ Agent 1: Security analysis
  ├─ Agent 2: Performance review
  └─ Agent 3: Type checking

All three agents run simultaneously
Results combined when all complete
```

### Agent Chaining

Complex workflows use sequential agents:

```
1. refactor-planner → Creates refactoring plan
2. plan-reviewer → Reviews the plan
3. code-refactor-master → Executes the plan
4. code-architecture-reviewer → Verifies result
```

---

## Hard Rules System

### Purpose

Hard rules provide **persistent guidelines** that Claude follows throughout development sessions. Unlike skills (which activate contextually), rules are **always active** and guide decision-making.

### Rule Categories

**1. Security Rules** (security.md)
- No hardcoded secrets
- Input validation
- Injection prevention
- Authentication/authorization

**2. Git Workflow Rules** (git-workflow.md)
- Conventional commits
- PR requirements
- Feature implementation workflow

**3. Coding Style Rules** (coding-style.md)
- Immutability (CRITICAL)
- File organization
- Error handling
- Input validation

**4. Testing Rules** (testing.md)
- 80% minimum coverage
- TDD workflow (RED → GREEN → REFACTOR)
- Unit, integration, and E2E tests

**5. Agent Orchestration Rules** (agents.md)
- When to use which agent
- Parallel execution guidelines
- Multi-perspective analysis

**6. Performance Rules** (performance.md)
- Model selection strategy
- Context window management
- Ultrathink + Plan Mode for complex tasks

**7. Common Patterns Rules** (patterns.md)
- API response format
- Repository pattern
- Custom hooks pattern
- Skeleton project approach

### Enforcement

**Rules provide guidelines, not strict enforcement.**

For strict enforcement:
1. **Skill enforcement** - Set `"enforcement": "block"` in skill-rules.json
2. **PreToolUse hooks** - Block operations before execution
3. **Agents** - code-reviewer, security-reviewer for validation

---

## Hooks Architecture

### Hook Types

**1. PreToolUse Hooks**
- Run BEFORE tool execution
- Can modify parameters or block execution
- Example: Validate code before commit

**2. PostToolUse Hooks**
- Run AFTER tool execution
- Can perform cleanup or checks
- Example: Run prettier after file edit

**3. Stop Hooks**
- Run when session ends
- Final verification
- Example: Check for console.log before session ends

### Essential Hooks (in base)

**1. skill-activation-prompt** (UserPromptSubmit hook)
```typescript
// Runs before Claude sees user prompt
// Reads skill-rules.json
// Matches triggers (keywords, intent, file paths)
// Injects skill suggestions
```

**2. post-tool-use-tracker** (PostToolUse hook)
```bash
# Tracks file changes after tool use
# Updates context for smarter skill suggestions
# Logs operations for debugging
```

### Advanced Hooks (optional)

**Validation:**
- **tsc-check** - Run TypeScript compiler after edits
- **stop-build-check-enhanced** - Verify build before session ends

**Automation:**
- **trigger-build-resolver** - Auto-launch build-error-resolver on failures
- **error-handling-reminder** - Remind about error handling patterns

---

## Progressive Disclosure Pattern

### The 500-Line Rule

**Problem:** Large skills exceed context limits and slow performance.

**Solution:** Modular skill structure with progressive disclosure.

### Modular Structure

```
skill-name/
├── SKILL.md              # <500 lines - Overview + navigation
└── resources/
    ├── topic-1.md        # <500 lines - Specific topic
    ├── topic-2.md        # <500 lines - Another topic
    └── examples.md       # <500 lines - Code examples
```

### Loading Strategy

**Initial Load:**
- SKILL.md loaded when skill activates
- Contains overview and links to resources
- <500 lines to fit comfortably in context

**On-Demand Loading:**
- Resource files loaded only when explicitly referenced
- User or Claude requests: "Show me authentication examples"
- Specific resource loaded: `resources/authentication.md`

**Benefits:**
- Avoid context window bloat
- Faster initial skill activation
- Load only what's needed for current task

### Example: backend-dev-guidelines

```
backend-dev-guidelines/
├── SKILL.md                        # Overview, navigation
└── resources/
    ├── routing-and-controllers.md  # Route patterns
    ├── services-and-repositories.md # Service layer
    ├── middleware-guide.md          # Middleware patterns
    ├── validation-patterns.md       # Input validation
    ├── async-and-errors.md          # Error handling
    └── complete-examples.md         # Full examples
```

User asks: "How do I structure my routes?"
→ SKILL.md references routing-and-controllers.md
→ Claude reads only that resource

---

## Multi-Project Template Philosophy

### Design as a Starter Template

**Goal:** Reusable template for launching new projects, not a one-off showcase.

**Approach:**
1. **Universal base** - Works for all project types
2. **Clear separation** - Universal vs domain-specific
3. **Easy discovery** - Categorical organization
4. **Copy-friendly** - Simple cp commands to integrate

### Cross-Project Applicability

**AI Research Agents:**
- Base template sufficient (planning, code review, TDD, build troubleshooting)
- No additions needed

**Full-Stack Web Apps:**
- Base template + backend/frontend skills
- Optional: E2E testing, error tracking

**Mac Applications:**
- Base template sufficient
- Optional: Native app patterns skill

**Data Science Projects:**
- Base template sufficient
- Optional: Data science patterns skill

### Customization Strategy

**1. Copy Base**
```bash
cp -r .claude/ /path/to/new-project/
```

**2. Add Domain Skills** (if needed)
```bash
cp -r optional-components/skills/backend/backend-dev-guidelines/ .claude/skills/
```

**3. Customize Rules** (if needed)
```bash
vim .claude/rules/coding-style.md  # Update for team standards
```

**4. Install Dependencies**
```bash
cd .claude/hooks/
npm install
```

**5. Test**
- Edit a file → hooks run
- Type trigger keywords → skills activate
- Use slash commands → agents launch

---

## Benefits of This Architecture

### 1. Truly Universal

- Works for AI research, web apps, Mac apps, data science without modifications
- No tech stack assumptions in base template
- Add domain-specifics only when needed

### 2. Easy Discovery

- Categorical organization (testing/, debugging/, backend/, frontend/)
- Clear READMEs in each category
- Obvious what belongs where

### 3. Production-Tested

- 6 months of original development
- 10+ months of everything-claude-code patterns
- Real-world usage across multiple projects

### 4. Performance Optimized

- Progressive disclosure (500-line rule) avoids context bloat
- Model selection strategy (Haiku/Sonnet/Opus)
- Parallel agent execution for efficiency

### 5. Flexible & Extensible

- Copy entire `.claude/` or cherry-pick components
- Create custom skills using skill-developer
- Customize rules for team standards
- Add project-specific agents

### 6. Self-Documenting

- Comprehensive READMEs at every level
- Hard rules explain "why" not just "what"
- Skills include examples and best practices
- Agents document their own purpose and usage

---

## Evolution & Maintenance

### Regular Review Process

**Quarterly:**
- Review base template components
- Identify non-universal patterns that snuck in
- Consider promoting popular optional components to base
- Remove unused optional components

**After Major Projects:**
- Extract new universal patterns
- Create new optional components for specialized workflows
- Update documentation with lessons learned

### Community Contributions

**Accepting:**
- New optional skills for specific frameworks
- Additional specialized agents
- Bug fixes and improvements
- Documentation enhancements

**Not Accepting:**
- Components that break universality principle
- Duplicate functionality without clear improvement
- Insufficiently tested patterns

### Version Control

- Tag major template versions
- Maintain CHANGELOG.md
- Provide migration guides for breaking changes
- Preserve legacy-components for reference

---

## Conclusion

This architecture represents a **philosophy shift** from minimal-by-default to comprehensive-by-default. The result is a template that works immediately for most project types while remaining flexible for specialized needs.

**Key Takeaways:**
- Base template is comprehensive and universal (12 agents, 6 commands, 3 skills)
- Optional components are well-organized and easy to discover (7 agents, 9 skills, 5 commands)
- Progressive disclosure keeps context manageable
- Skill auto-activation ensures relevant components suggest themselves
- Production-tested patterns from real projects

**Next Steps:**
- Copy `.claude/` to your project
- Add domain-specific components as needed
- Customize rules for your team
- Build with confidence

---

## Learn More

- **Main README:** [README.md](README.md)
- **Setup Guide:** [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md)
- **Rules Documentation:** [.claude/rules/README.md](.claude/rules/README.md)
- **Skills Documentation:** [.claude/skills/README.md](.claude/skills/README.md)
- **Agents Documentation:** [.claude/agents/README.md](.claude/agents/README.md)
- **Commands Documentation:** [.claude/commands/README.md](.claude/commands/README.md)
- **Hooks Documentation:** [.claude/hooks/README.md](.claude/hooks/README.md)
