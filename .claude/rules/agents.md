# Agent Orchestration Rules

## Proactive Agent Invocation

Claude MUST invoke these tools/agents automatically (no user prompt needed):

| Trigger | Tool/Agent | Timing |
|---------|------------|--------|
| Complex feature request | **EnterPlanMode** (built-in) | Before implementation |
| Code written/modified | **code-reviewer** | Immediately after changes |
| New feature or bug fix | **tdd-guide** | Before writing implementation |
| Architectural decision | **architect** | When design choices arise |
| Build failure | **build-error-resolver** | When build/compile fails |
| Security-sensitive code | **security-reviewer** | Before committing auth/input handling |

**Critical:** These are behavioral requirements. Claude should invoke tools/agents without asking permission.

**Note on Planning:** For complex features, Claude uses the built-in `EnterPlanMode` tool which creates structured plans in `~/.claude/plans/`. After approval, use `/dev-docs` to convert the plan into persistent task tracking.

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
EnterPlanMode (built-in) → ExitPlanMode (approval) → /dev-docs → execute
```
- **EnterPlanMode**: Built-in tool creates structured implementation plan
- **ExitPlanMode**: User approves plan before proceeding
- **/dev-docs**: Converts approved plan into persistent task tracking
- **architect**: Optional - for complex architectural decisions before planning

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

**Universal agents (11):** architect, plan-reviewer, code-reviewer, code-architecture-reviewer, refactor-planner, code-refactor-master, security-reviewer, tdd-guide, build-error-resolver, documentation-architect, web-research-specialist

**Built-in Planning:** Claude Code's native `EnterPlanMode` tool replaces the custom planner agent. Plans are saved to `~/.claude/plans/`.

**Optional agents:** See `optional-components/agents/` for domain-specific agents
