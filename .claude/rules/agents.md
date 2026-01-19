# Agent Orchestration

## Available Agents

### Universal Agents (In Base Template)

Located in `.claude/agents/` - available in all projects:

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **Planning & Architecture** | | |
| planner | Four-phase implementation planning | Complex features, new functionality |
| architect | System design and architectural decisions | Technical architecture, design patterns |
| plan-reviewer | Review plans before implementation | Validate implementation approach |
| **Code Quality** | | |
| code-reviewer | Comprehensive code review | After writing/modifying code |
| code-architecture-reviewer | Architectural consistency review | Ensure code matches patterns |
| refactor-planner | Plan refactoring strategies | Before major refactoring |
| code-refactor-master | Execute refactoring plans | Reorganize code structure |
| **Security & Testing** | | |
| security-reviewer | Security vulnerability analysis | Before commits, security-critical code |
| tdd-guide | Test-driven development enforcement | New features, bug fixes |
| **Build & Documentation** | | |
| build-error-resolver | Fix build and compilation errors | When build fails |
| documentation-architect | Create comprehensive documentation | Document features, APIs, architecture |
| **Research** | | |
| web-research-specialist | Research solutions and patterns | Debug issues, find best practices |

**Total: 12 universal agents** available in every project

### Optional Specialized Agents

Located in `optional-components/agents/` - copy as needed:

| Category | Agents | Purpose |
|----------|--------|---------|
| Testing | e2e-runner | Playwright E2E testing |
| Debugging | frontend-error-fixer, auto-error-resolver, auth-route-debugger | Stack-specific debugging |
| Maintenance | refactor-cleaner, doc-updater | Code cleanup, doc sync |
| Domain-Specific | auth-route-tester | JWT authentication testing |

## Immediate Agent Usage

Use these agents proactively without waiting for user prompt:

1. **Complex feature requests** → Use **planner** agent
2. **Code just written/modified** → Use **code-reviewer** agent
3. **New feature or bug fix** → Use **tdd-guide** agent
4. **Architectural decision** → Use **architect** agent
5. **Build failure** → Use **build-error-resolver** agent
6. **Security-critical code** → Use **security-reviewer** agent

## Parallel Task Execution

ALWAYS use parallel Task execution for independent operations:

```markdown
# GOOD: Parallel execution
Launch 3 agents in parallel:
1. Agent 1: Security analysis of auth.ts
2. Agent 2: Performance review of cache system
3. Agent 3: Type checking of utils.ts

# BAD: Sequential when unnecessary
First agent 1, then agent 2, then agent 3
```

## Multi-Perspective Analysis

For complex problems, use split role sub-agents:
- Factual reviewer
- Senior engineer
- Security expert
- Consistency reviewer
- Redundancy checker
