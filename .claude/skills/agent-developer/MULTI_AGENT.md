# Multi-Agent Workflow Patterns

Comprehensive guide to designing and implementing multi-agent workflows.

---

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Parallel Execution](#parallel-execution)
3. [Sequential Chaining](#sequential-chaining)
4. [Pipeline Patterns](#pipeline-patterns)
5. [Split-Role Analysis](#split-role-analysis)
6. [Orchestration Patterns](#orchestration-patterns)
7. [Error Handling](#error-handling)
8. [Best Practices](#best-practices)

---

## Core Concepts

### Why Multi-Agent?

From Anthropic's documentation:

1. **Context Isolation** - Sub-agents work with isolated context windows
2. **Parallelization** - Multiple agents work simultaneously
3. **Specialization** - Each agent focuses on specific expertise
4. **Context Preservation** - Main agent context preserved for later use

### Agent Communication

Agents communicate through:
- **Return values** - Agent outputs returned to caller
- **File system** - Write/read shared files
- **Task tool** - Launch and receive results

### Sub-Agent Benefits

From Claude Code Best Practices:
> "Telling Claude to use subagents to verify details or investigate particular questions it might have, especially early on in a conversation, tends to preserve context availability without much downside."

---

## Parallel Execution

### When to Parallelize

**DO parallelize when:**
- Tasks are independent
- No data dependencies
- Different files/components
- Multiple perspectives needed

**DON'T parallelize when:**
- Output depends on another agent
- Same files being modified
- Sequential logic required

### Parallel Pattern

```
┌─────────────────────────────────────┐
│           Main Agent                │
│                                     │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐│
│  │ Agent A │ │ Agent B │ │ Agent C ││
│  │ (Task 1)│ │ (Task 2)│ │ (Task 3)││
│  └────┬────┘ └────┬────┘ └────┬────┘│
│       │          │          │      │
│       └──────────┼──────────┘      │
│                  ▼                  │
│           Aggregate Results         │
└─────────────────────────────────────┘
```

### Implementation

```markdown
Launch 3 agents in parallel:

**Agent 1: Security Analysis**
- Task: Review auth.ts for vulnerabilities
- Output: Security findings

**Agent 2: Performance Review**
- Task: Analyze cache implementation
- Output: Performance recommendations

**Agent 3: Type Checking**
- Task: Review types in utils.ts
- Output: Type issues

*Wait for all agents to complete, then aggregate results.*
```

### Parallel Use Cases

| Use Case | Agents | Purpose |
|----------|--------|---------|
| Multi-file review | code-reviewer x N | Review different files |
| Comprehensive analysis | security + performance + code | Different perspectives |
| Research | web-research x N | Search different sources |
| Plan validation | Multiple plan-reviewers | Diverse feedback |

---

## Sequential Chaining

### When to Chain

**Use sequential when:**
- Output feeds into next step
- Dependencies exist
- Logical ordering required
- Build-on-previous needed

### Chain Pattern

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│ Agent A │ ──► │ Agent B │ ──► │ Agent C │
│         │     │         │     │         │
│ Output  │     │ Uses A  │     │ Uses B  │
└─────────┘     └─────────┘     └─────────┘
```

### Common Chains

#### Planning Chain
```
architect → planner → plan-reviewer → execute
```
1. **architect** - High-level design decisions
2. **planner** - Detailed implementation plan
3. **plan-reviewer** - Validate plan
4. **execute** - Implement the plan

#### Refactoring Chain
```
refactor-planner → code-refactor-master → code-reviewer
```
1. **refactor-planner** - Create refactoring strategy
2. **code-refactor-master** - Execute refactoring
3. **code-reviewer** - Verify quality

#### Feature Development Chain
```
tdd-guide → implement → code-reviewer → security-reviewer
```
1. **tdd-guide** - Write tests first
2. **implement** - Write code to pass tests
3. **code-reviewer** - Quality review
4. **security-reviewer** - Security check

---

## Pipeline Patterns

### Review Pipeline

```
Code Change → Review → Fix → Re-Review → Merge
```

```markdown
## Review Pipeline

1. **Initial Review** (code-reviewer)
   - Input: Changed files
   - Output: Issue list with severity

2. **Fix Issues** (implementation)
   - Input: Issue list
   - Output: Fixed code

3. **Re-Review** (code-reviewer)
   - Input: Fixed code
   - Output: Verification or new issues

4. **Loop until clean** or max iterations
```

### Build Pipeline

```
Change → Build → Fix Errors → Rebuild → Verify
```

```markdown
## Build Pipeline

1. **Run Build** (bash)
   - Command: npm run build
   - Output: Errors or success

2. **If errors, use build-error-resolver**
   - Input: Build errors
   - Output: Fixes applied

3. **Rebuild and verify**
   - Loop until success or max attempts
```

### Security Pipeline

```
Code → Security Scan → Fix Critical → Re-Scan → Commit
```

```markdown
## Security Pipeline

1. **Security Scan** (security-reviewer)
   - Input: Code changes
   - Output: Vulnerabilities by severity

2. **Fix Critical/High**
   - Block if CRITICAL unfixed
   - Address HIGH issues

3. **Re-Scan**
   - Verify fixes
   - Check for new issues

4. **Commit if clean**
```

---

## Split-Role Analysis

### Concept

Use multiple agents with different perspectives to analyze the same thing:

From Claude Code Best Practices:
> "Use split role sub-agents for diverse analysis."

### Perspectives

| Role | Focus | Questions Asked |
|------|-------|-----------------|
| **Factual Reviewer** | Accuracy | Is this claim true? |
| **Senior Engineer** | Best practices | Is this well-engineered? |
| **Security Expert** | Vulnerabilities | Is this secure? |
| **Consistency Reviewer** | Alignment | Does this fit the codebase? |
| **Redundancy Checker** | Duplication | Is there overlap? |

### Implementation

```markdown
## Split-Role Analysis: New Authentication System

**Agent 1: Security Expert**
- Focus: Vulnerabilities in auth flow
- Check: OWASP Top 10, credential handling

**Agent 2: Senior Engineer**
- Focus: Code quality and patterns
- Check: Best practices, maintainability

**Agent 3: Consistency Reviewer**
- Focus: Alignment with existing code
- Check: Naming, patterns, conventions

**Agent 4: Performance Reviewer**
- Focus: Scalability concerns
- Check: Session management, caching

*Aggregate all perspectives into unified recommendation.*
```

### When to Use

- Architectural decisions
- Security-critical features
- Complex refactoring plans
- Technology evaluations
- Trade-off analysis

---

## Orchestration Patterns

### Coordinator Pattern

One agent coordinates multiple specialists:

```
              ┌─────────────┐
              │ Coordinator │
              │   (Opus)    │
              └──────┬──────┘
         ┌──────────┼──────────┐
         ▼          ▼          ▼
   ┌─────────┐ ┌─────────┐ ┌─────────┐
   │Specialist│ │Specialist│ │Specialist│
   │    A    │ │    B    │ │    C    │
   │ (Sonnet)│ │ (Sonnet)│ │ (Haiku) │
   └─────────┘ └─────────┘ └─────────┘
```

### Escalation Pattern

Simple agents escalate to complex ones:

```
┌────────┐        ┌────────┐        ┌───────┐
│ Haiku  │ ─────► │ Sonnet │ ─────► │ Opus  │
│ Simple │  if    │ Medium │  if    │Complex│
│ Check  │complex │ Handle │complex │Handle │
└────────┘        └────────┘        └───────┘
```

### Fan-Out/Fan-In Pattern

```
              ┌───────────┐
              │   Fan     │
              │   Out     │
              └─────┬─────┘
         ┌─────────┼─────────┐
         ▼         ▼         ▼
    ┌────────┐ ┌────────┐ ┌────────┐
    │Worker 1│ │Worker 2│ │Worker 3│
    └────┬───┘ └────┬───┘ └────┬───┘
         │         │         │
         └─────────┼─────────┘
                   ▼
              ┌─────────┐
              │  Fan    │
              │   In    │
              └─────────┘
```

---

## Error Handling

### Retry Strategy

```markdown
## Error Handling

1. **First failure** - Retry with same agent
2. **Second failure** - Retry with more capable model
3. **Third failure** - Report to user for intervention
```

### Graceful Degradation

```markdown
## Degradation Strategy

If security-reviewer fails:
1. Try with simpler scope
2. Fall back to basic checks
3. Report partial results
4. Flag for manual review
```

### Failure Isolation

```markdown
## Isolation Strategy

Parallel agents run independently:
- Agent A fails → Don't block Agent B
- Collect successful results
- Report failures separately
- Continue with available data
```

---

## Best Practices

### 1. Minimize Context Transfer

Pass only necessary information between agents:

```markdown
# Good
Agent A output: "Found 3 issues in auth.ts: line 42, 67, 89"

# Bad
Agent A output: [entire file contents + analysis + history]
```

### 2. Use Appropriate Models

```
Coordinator: Opus (complex orchestration)
Workers: Sonnet (standard tasks)
Validators: Haiku (simple checks)
```

### 3. Design for Failure

Every workflow should handle:
- Agent timeout
- Agent error
- Unexpected output
- Partial completion

### 4. Parallelize Aggressively

When tasks are independent:
```markdown
# Good: Parallel
Launch all review agents simultaneously

# Bad: Sequential (when unnecessary)
Wait for security, then performance, then code review
```

### 5. Clear Interfaces

Define exactly what each agent:
- Receives as input
- Produces as output
- Can and cannot do

### 6. Verification at Boundaries

Verify before passing to next stage:
```markdown
Agent A completes → Verify output valid → Pass to Agent B
```

### 7. Progress Visibility

For long workflows:
```markdown
[1/4] Planning phase complete
[2/4] Security review complete
[3/4] Implementation complete
[4/4] Final review complete
```

---

## Example Workflows

### Feature Implementation Workflow

```markdown
## Workflow: Implement User Authentication

### Phase 1: Planning (Sequential)
1. **architect** - Design auth approach
2. **planner** - Create implementation plan
3. **plan-reviewer** - Validate plan

### Phase 2: Implementation (Sequential with parallel reviews)
4. **tdd-guide** - Write tests first
5. Implement feature
6. **Parallel review:**
   - code-reviewer
   - security-reviewer

### Phase 3: Finalization (Sequential)
7. Address review findings
8. **build-error-resolver** - If build fails
9. Final verification
```

### Code Review Workflow

```markdown
## Workflow: Comprehensive Code Review

### Parallel Analysis
Launch simultaneously:
- **code-reviewer** - Quality issues
- **security-reviewer** - Security issues
- **code-architecture-reviewer** - Pattern issues

### Aggregation
Combine findings:
- Deduplicate issues
- Prioritize by severity
- Create unified report

### Follow-up
If CRITICAL/HIGH issues:
- Fix issues
- Re-review changed files
```

### Research Workflow

```markdown
## Workflow: Debug Unknown Issue

### Phase 1: Parallel Research
Launch simultaneously:
- **web-research-specialist** (GitHub issues)
- **web-research-specialist** (Stack Overflow)
- **web-research-specialist** (Documentation)

### Phase 2: Synthesis
Aggregate findings:
- Compare solutions
- Evaluate applicability
- Recommend approach

### Phase 3: Implementation
- Apply recommended fix
- Verify resolution
```

---

## Anti-Patterns

### 1. Over-Orchestration

```markdown
# Bad: Too many agents for simple task
Coordinator → Analyzer → Validator → Fixer → Verifier

# Good: One capable agent
build-error-resolver (handles all steps)
```

### 2. Unnecessary Sequencing

```markdown
# Bad: Sequential when parallel is possible
Review A, then Review B, then Review C

# Good: Parallel when independent
Review A, B, C simultaneously
```

### 3. Missing Error Handling

```markdown
# Bad: No failure handling
Run Agent A → Run Agent B → Done

# Good: Handle failures
Run Agent A → If fail, retry/escalate → Run Agent B
```

### 4. Too Much Context Passing

```markdown
# Bad: Pass everything
Agent A passes entire codebase analysis to Agent B

# Good: Pass minimal needed
Agent A passes specific file paths and issue summary
```
