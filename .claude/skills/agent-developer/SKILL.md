---
name: agent-developer
description: Create and manage Claude Code agents following Anthropic best practices. Use when creating new agents, designing multi-agent workflows, selecting models for agents, understanding agent patterns, debugging agent activation, or implementing agent chaining. Covers agent structure, YAML frontmatter, tool selection, model selection (Haiku/Sonnet/Opus), parallel execution, sub-agents, verification patterns, and the Task tool.
---

# Agent Developer Guide

## Purpose

Comprehensive guide for creating and managing agents in Claude Code, following Anthropic's official best practices from the Claude Agent SDK documentation and Claude Code best practices.

## When to Use This Skill

Automatically activates when you mention:
- Creating or adding agents
- Designing sub-agents or multi-agent workflows
- Selecting models for agents (Haiku, Sonnet, Opus)
- Agent chaining or parallel execution
- Understanding how agents work
- Debugging agent activation issues
- Task tool usage patterns
- Agent verification strategies

---

## Core Principles (from Anthropic)

### 1. Give Agents a Computer

The foundational principle from the Claude Agent SDK: **"give your agents a computer, allowing them to work like humans do."** Agents should be able to:
- Write and edit files
- Run commands
- Verify their own work
- Iterate until completion

### 2. Feedback Loop Architecture

Agents operate in a continuous loop:
```
Gather Context → Take Action → Verify Work → Repeat
```

This structure should guide every agent you design.

### 3. Verification is Key

From Anthropic's Boris Cherny: "Giving the AI a way to verify its own work improves the quality of the final result by 2-3x."

**Verification strategies:**
- Rule-based feedback (clearly defined output rules)
- Visual feedback (screenshots for UI tasks)
- LLM-as-judge (auxiliary models to evaluate outputs)
- Test execution (run tests to validate changes)

---

## Quick Start: Creating a New Agent

### Step 1: Create Agent File

**Location:** `.claude/agents/{agent-name}.md`

**Template:**
```markdown
---
name: my-new-agent
description: Brief description including when to use. Be explicit about triggers and use cases.
tools: Read, Grep, Glob
model: sonnet
---

You are a specialized [role] agent focused on [primary purpose].

## Your Role

[2-3 sentences describing what this agent does]

## Key Responsibilities

- Responsibility 1
- Responsibility 2
- Responsibility 3

## Process

### 1. Analysis Phase
- Understand the context
- Gather necessary information
- Identify requirements

### 2. Execution Phase
- [Task-specific steps]
- [More steps]

### 3. Verification Phase
- Verify work is complete
- Provide clear output
- Suggest next steps

## Output Format

[Define the exact format for agent output]

## Best Practices

1. Be thorough in your specialty
2. Follow existing project patterns
3. Provide actionable outputs
```

### Step 2: Choose Tools Appropriately

**Read-only agents** (research, analysis, review):
```yaml
tools: Read, Grep, Glob
```

**Implementation agents** (can modify code):
```yaml
tools: Read, Write, Edit, Grep, Glob
```

**Full access agents** (need shell commands):
```yaml
tools: Read, Write, Edit, Bash, Grep, Glob
```

**All tools** (rare, for orchestration):
```yaml
tools: All tools
```

### Step 3: Select Model

See [MODEL_SELECTION.md](MODEL_SELECTION.md) for detailed guidance.

**Quick Reference:**
- **Haiku** - Simple, repetitive tasks (90% of Sonnet capability, 3x cost savings)
- **Sonnet** - Most coding tasks (default, balanced)
- **Opus** - Complex reasoning, architectural decisions

### Step 4: Test the Agent

```bash
# Manually invoke via Task tool in Claude Code
"Use the my-new-agent agent to [task]"
```

---

## Agent Types

### 1. Planning Agents

**Purpose:** Design and plan before execution

**Characteristics:**
- Read-only tools (Glob, Grep, Read)
- Opus model for deep reasoning
- Output: Detailed plans, not code
- Examples: planner, architect, plan-reviewer

**When to Use:**
- Complex feature implementation
- Architectural decisions
- Before major refactoring

### 2. Review Agents

**Purpose:** Validate and improve existing work

**Characteristics:**
- Read-only tools (analysis)
- Sonnet model (balanced)
- Output: Categorized findings with severity
- Examples: code-reviewer, security-reviewer

**When to Use:**
- After code is written
- Before commits
- Security-sensitive changes

### 3. Implementation Agents

**Purpose:** Execute specific tasks autonomously

**Characteristics:**
- Full tool access (Edit, Write, Bash)
- Sonnet model (coding focus)
- Output: Modified files + verification
- Examples: build-error-resolver, code-refactor-master

**When to Use:**
- Specific implementation tasks
- Error fixing
- Refactoring execution

### 4. Research Agents

**Purpose:** Gather information from various sources

**Characteristics:**
- Read + Web tools (WebFetch, WebSearch)
- Sonnet or Haiku model
- Output: Summarized findings with sources
- Examples: web-research-specialist

**When to Use:**
- Debugging issues
- Finding solutions
- Technical research

---

## Agent Invocation Patterns

### Proactive Invocation (Recommended)

Agents should be invoked **automatically** when context matches:

| Trigger | Agent | Timing |
|---------|-------|--------|
| Complex feature request | planner | Before implementation |
| Code written/modified | code-reviewer | Immediately after changes |
| New feature or bug fix | tdd-guide | Before writing implementation |
| Build failure | build-error-resolver | When build fails |
| Security-sensitive code | security-reviewer | Before committing |

### On-Demand Invocation

User explicitly requests:
```
"Use the security-reviewer agent to check this code"
```

### Chained Invocation

Sequential agents for complex workflows:
```
architect → planner → plan-reviewer → execute
```

---

## Parallel vs Sequential Execution

### When to Run in Parallel

**DO parallelize when:**
- Agents analyze different files
- Independent code reviews
- Separate research tasks
- Multiple planning perspectives

**Example:**
```markdown
Launch 3 agents in parallel:
- Agent 1: Security analysis of auth.ts
- Agent 2: Performance review of cache system
- Agent 3: Type checking of utils.ts
```

### When to Run Sequentially

**DON'T parallelize when:**
- Output of one agent informs another
- Dependent file changes
- Chain of refactoring steps

**Example:**
```
1. refactor-planner creates plan
2. plan-reviewer validates plan
3. code-refactor-master executes
4. code-reviewer verifies result
```

---

## Sub-Agent Best Practices

From Anthropic's documentation:

### Benefits of Sub-Agents

1. **Context Isolation** - Work independently with isolated context windows
2. **Parallelization** - Multiple agents work simultaneously
3. **Specialization** - Each agent focuses on specific expertise
4. **Context Preservation** - Main agent context preserved

### When to Use Sub-Agents

- Verify details or investigate questions
- Early in conversation (preserves context)
- Independent verification of work
- Complex tasks requiring multiple perspectives

### Sub-Agent Pattern: Split Role Analysis

For complex decisions, use multiple perspectives:
```
- Factual reviewer (verify claims)
- Senior engineer (best practices)
- Security expert (vulnerability analysis)
- Consistency reviewer (alignment with codebase)
```

---

## Verification Patterns

### 1. Test Execution Verification

```markdown
## Verification Phase
1. Run relevant tests
2. Verify tests pass
3. Check coverage didn't decrease
```

### 2. Build Verification

```markdown
## Verification Phase
1. Run build command
2. Verify no new errors
3. Check no type regressions
```

### 3. Review Verification

```markdown
## Verification Phase
1. Use code-reviewer agent to review changes
2. Address CRITICAL and HIGH issues
3. Document any deferred issues
```

### 4. Visual Verification (UI)

From Anthropic: "Claude tests every single change...using a browser, tests the UI, and iterates until the code works and the UX feels good."

```markdown
## Verification Phase
1. Take screenshot of UI
2. Verify visual appearance
3. Test user interactions
```

---

## Agent Design Checklist

When creating a new agent, verify:

- [ ] Clear, specific name (lowercase-hyphenated)
- [ ] Description includes trigger keywords
- [ ] Appropriate tool selection (minimum needed)
- [ ] Correct model selection (Haiku/Sonnet/Opus)
- [ ] Single responsibility (one thing well)
- [ ] Clear output format defined
- [ ] Verification step included
- [ ] Process is step-by-step
- [ ] Examples provided
- [ ] Integrates with existing agents

---

## Reference Files

For detailed information on specific topics:

### [AGENT_PATTERNS.md](AGENT_PATTERNS.md)
Complete agent pattern library:
- Planning agent pattern
- Review agent pattern
- Implementation agent pattern
- Research agent pattern
- Orchestration agent pattern
- Copy-paste ready templates

### [MODEL_SELECTION.md](MODEL_SELECTION.md)
Detailed model selection guidance:
- When to use Haiku (cost optimization)
- When to use Sonnet (default coding)
- When to use Opus (complex reasoning)
- Cost/performance trade-offs
- Model switching strategies

### [MULTI_AGENT.md](MULTI_AGENT.md)
Multi-agent workflow patterns:
- Parallel execution strategies
- Agent chaining patterns
- Split-role analysis
- Orchestration patterns
- Error handling in workflows

---

## Existing Agents Reference

### Universal Agents (12)

| Agent | Purpose | Model | Tools |
|-------|---------|-------|-------|
| planner | Implementation planning | Opus | Read-only |
| architect | System design | Sonnet | Read-only |
| plan-reviewer | Validate plans | Sonnet | Read-only |
| code-reviewer | Code quality | Sonnet | Read-only |
| code-architecture-reviewer | Architecture consistency | Sonnet | Read-only |
| refactor-planner | Refactoring strategy | Sonnet | Read-only |
| code-refactor-master | Execute refactoring | Sonnet | Full |
| security-reviewer | Security analysis | Opus | Full |
| tdd-guide | Test-driven development | Sonnet | Full |
| build-error-resolver | Fix build errors | Sonnet | Full |
| documentation-architect | Generate docs | Sonnet | Full |
| web-research-specialist | Research issues | Sonnet | Web tools |

### Optional Agents (7)

See `optional-components/agents/` for domain-specific agents.

---

## Common Mistakes

### 1. Too Many Tools

```yaml
# ❌ Wrong: Giving all tools when not needed
tools: All tools

# ✅ Correct: Minimum tools for the task
tools: Read, Grep, Glob
```

### 2. Wrong Model

```yaml
# ❌ Wrong: Opus for simple tasks
model: opus  # For a simple code formatter

# ✅ Correct: Match model to complexity
model: haiku  # Simple, repetitive task
```

### 3. No Verification

```markdown
# ❌ Wrong: No verification step
## Process
1. Make changes
2. Done

# ✅ Correct: Include verification
## Process
1. Make changes
2. Verify changes work
3. Report results
```

### 4. Vague Responsibilities

```markdown
# ❌ Wrong: Too vague
## Your Role
Help with code stuff

# ✅ Correct: Specific responsibilities
## Your Role
Review TypeScript code for OWASP Top 10 vulnerabilities, focusing on input validation, authentication, and injection prevention.
```

---

## Quick Reference Summary

### Create New Agent (5 Steps)

1. Create `.claude/agents/{name}.md` with frontmatter
2. Choose appropriate tools (minimum needed)
3. Select model (Haiku/Sonnet/Opus)
4. Define clear process and output format
5. Include verification step

### Tool Selection

- **Read-only**: `Read, Grep, Glob` (review, planning)
- **Implementation**: `Read, Write, Edit, Grep, Glob` (code changes)
- **Full access**: Add `Bash` (shell commands needed)

### Model Selection

- **Haiku**: Simple tasks, frequent invocation, cost savings
- **Sonnet**: Most coding tasks (default)
- **Opus**: Complex reasoning, architectural decisions

### Invocation

- **Proactive**: Automatically when context matches
- **On-demand**: Explicit user request
- **Chained**: Sequential workflow steps

---

## Related Files

**Configuration:**
- `.claude/agents/` - All agent files
- `.claude/rules/agents.md` - Invocation rules

**Documentation:**
- `.claude/agents/README.md` - Agent catalog
- `optional-components/agents/README.md` - Optional agents

**Commands:**
- `.claude/commands/create-agent.md` - Agent creation wizard

---

## Sources

- [Claude Code: Best practices for agentic coding](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Building agents with the Claude Agent SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
- [Agent Skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

---

**Skill Status**: COMPLETE - Following Anthropic best practices
**Line Count**: < 500 (following 500-line rule)
**Progressive Disclosure**: Reference files for detailed information
