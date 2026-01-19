# Agent Orchestration Rules

## Proactive Agent Invocation

Claude MUST invoke these agents automatically (no user prompt needed):

| Trigger | Agent | Timing |
|---------|-------|--------|
| Complex feature request | **planner** | Before implementation |
| Code written/modified | **code-reviewer** | Immediately after changes |
| New feature or bug fix | **tdd-guide** | Before writing implementation |
| Architectural decision | **architect** | When design choices arise |
| Build failure | **build-error-resolver** | When build/compile fails |
| Security-sensitive code | **security-reviewer** | Before committing auth/input handling |

**Critical:** These are behavioral requirements. Claude should invoke agents without asking permission.

---

## Parallel Execution Required

For independent tasks, ALWAYS use parallel Task execution (single message, multiple tool calls).

**Good: Parallel execution**
```markdown
Launch 3 agents in parallel:
- Agent 1: Security analysis of auth.ts
- Agent 2: Performance review of cache system
- Agent 3: Type checking of utils.ts
```

**Bad: Sequential when unnecessary**
```markdown
First agent 1, then agent 2, then agent 3
```

**When parallel is safe:**
- Agents analyzing different files
- Independent code reviews
- Separate research tasks
- Multiple planning perspectives

**When sequential is required:**
- Output of one agent informs another
- Dependent file changes
- Chain of refactoring steps

---

## Agent Chaining Patterns

### Planning Workflow
```
architect → planner → plan-reviewer → execute
```
- **architect**: Determine system design approach
- **planner**: Create detailed implementation plan
- **plan-reviewer**: Validate plan before execution

### Refactoring Workflow
```
refactor-planner → code-refactor-master → code-reviewer
```
- **refactor-planner**: Analyze and plan refactoring strategy
- **code-refactor-master**: Execute refactoring (file moves, restructuring)
- **code-reviewer**: Verify refactored code quality

### Security Workflow
```
security-reviewer → (fix issues) → code-reviewer
```
- **security-reviewer**: Identify vulnerabilities
- **code-reviewer**: Verify fixes don't introduce new issues

### Feature Development Workflow
```
tdd-guide → (write tests) → (implement) → code-reviewer → security-reviewer
```
- **tdd-guide**: Ensure test-first approach
- **code-reviewer**: Quality check after implementation
- **security-reviewer**: Security check before commit

---

## Multi-Perspective Analysis

For complex decisions, use split-role sub-agents:
- Factual reviewer (verify claims)
- Senior engineer (best practices)
- Security expert (vulnerability analysis)
- Consistency reviewer (alignment with codebase)
- Redundancy checker (identify duplication)

**Use when:**
- Making architectural decisions
- Reviewing complex refactoring plans
- Evaluating multiple implementation approaches
- Debugging intricate issues

---

## Agent Catalog

For full agent descriptions and capabilities, see [../agents/README.md](../agents/README.md)

**Universal agents (12):** planner, architect, plan-reviewer, code-reviewer, code-architecture-reviewer, refactor-planner, code-refactor-master, security-reviewer, tdd-guide, build-error-resolver, documentation-architect, web-research-specialist

**Optional agents:** See `optional-components/agents/` for domain-specific agents
