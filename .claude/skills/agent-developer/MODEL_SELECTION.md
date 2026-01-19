# Model Selection Guide

Detailed guidance on choosing the right model for your agents.

---

## Table of Contents

1. [Model Overview](#model-overview)
2. [When to Use Haiku](#when-to-use-haiku)
3. [When to Use Sonnet](#when-to-use-sonnet)
4. [When to Use Opus](#when-to-use-opus)
5. [Cost/Performance Trade-offs](#costperformance-trade-offs)
6. [Model Selection Matrix](#model-selection-matrix)
7. [Anthropic Recommendations](#anthropic-recommendations)

---

## Model Overview

### Haiku 4.5
- **Capability:** 90% of Sonnet capability
- **Cost:** ~3x cheaper than Sonnet
- **Speed:** Fastest response times
- **Best for:** Simple, repetitive tasks

### Sonnet 4.5
- **Capability:** Best coding model
- **Cost:** Balanced cost/performance
- **Speed:** Good response times
- **Best for:** Most development work

### Opus 4.5
- **Capability:** Deepest reasoning
- **Cost:** Most expensive
- **Speed:** Slower (more thinking)
- **Best for:** Complex decisions, architecture

---

## When to Use Haiku

**Haiku is ideal for:**

### 1. Lightweight Worker Agents
Agents that run frequently with simple tasks:
```yaml
model: haiku
# Good for: format-checker, lint-runner, simple-validator
```

### 2. Pair Programming Assistants
Rapid feedback during coding:
- Code completion suggestions
- Simple refactoring
- Syntax corrections

### 3. Multi-Agent Worker Nodes
When orchestrating many agents:
```
Orchestrator (Sonnet/Opus)
├── Worker 1 (Haiku) - Task A
├── Worker 2 (Haiku) - Task B
└── Worker 3 (Haiku) - Task C
```

### 4. Repetitive Operations
Tasks with predictable patterns:
- Bulk file renaming
- Import sorting
- Comment generation
- Simple transformations

### 5. Cost Optimization
When budget is constrained:
- Development/testing environments
- High-volume operations
- Non-critical tasks

**Haiku Examples:**
```yaml
---
name: import-sorter
description: Sorts imports in TypeScript files
tools: Read, Edit
model: haiku  # Simple, repetitive task
---
```

```yaml
---
name: format-checker
description: Checks if files are properly formatted
tools: Read, Bash
model: haiku  # Just runs prettier --check
---
```

---

## When to Use Sonnet

**Sonnet is the default for most agents.**

### 1. Main Development Work
Standard coding tasks:
- Feature implementation
- Bug fixes
- Refactoring

### 2. Code Review
Analyzing code quality:
```yaml
---
name: code-reviewer
description: Reviews code for quality issues
tools: Read, Grep, Glob
model: sonnet  # Needs good judgment
---
```

### 3. Multi-Agent Orchestration
Coordinating other agents:
- Task decomposition
- Result aggregation
- Workflow management

### 4. Complex Coding Tasks
Tasks requiring:
- Understanding context
- Making decisions
- Writing quality code

### 5. Research and Analysis
Moderate complexity research:
- Finding solutions
- Analyzing patterns
- Documentation review

**Sonnet Examples:**
```yaml
---
name: build-error-resolver
description: Diagnoses and fixes build errors
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet  # Needs to understand errors and fix them
---
```

```yaml
---
name: tdd-guide
description: Guides test-driven development
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet  # Needs to write good tests
---
```

---

## When to Use Opus

**Opus is for complex reasoning tasks.**

### 1. Architectural Decisions
System design requiring deep analysis:
```yaml
---
name: architect
description: Makes system design decisions
tools: Read, Grep, Glob
model: opus  # Needs deep reasoning
---
```

### 2. Complex Planning
Multi-phase implementation planning:
```yaml
---
name: planner
description: Creates comprehensive implementation plans
tools: Read, Grep, Glob
model: opus  # Needs to consider many factors
---
```

### 3. Security Analysis
Critical security review:
```yaml
---
name: security-reviewer
description: Identifies security vulnerabilities
tools: Read, Write, Edit, Bash, Grep, Glob
model: opus  # Security is critical
---
```

### 4. Complex Debugging
Hard-to-diagnose issues:
- Race conditions
- Memory leaks
- Architectural flaws

### 5. Maximum Quality Requirements
When quality > cost:
- Production-critical code
- Financial/security systems
- Complex algorithms

**Opus Examples:**
```yaml
---
name: system-designer
description: Designs complex distributed systems
tools: Read, Grep, Glob
model: opus  # Requires deep architectural thinking
---
```

```yaml
---
name: algorithm-optimizer
description: Optimizes complex algorithms for performance
tools: Read, Write, Edit
model: opus  # Requires deep understanding
---
```

---

## Cost/Performance Trade-offs

### Cost Comparison (Relative)

| Model | Input Cost | Output Cost | Speed |
|-------|-----------|-------------|-------|
| Haiku | 1x | 1x | Fastest |
| Sonnet | ~3x | ~3x | Fast |
| Opus | ~15x | ~15x | Slower |

### When Cost Matters

**Use Haiku when:**
- Running many agents in parallel
- High-frequency operations
- Development/testing
- Non-critical paths

**Use Sonnet when:**
- Quality matters
- Standard development
- User-facing features
- Code review

**Use Opus when:**
- Critical decisions
- Complex architecture
- Security-sensitive
- Quality is paramount

### Anthropic's Recommendation

From Boris Cherny (creator of Claude Code):

> "We use Opus 4.5 with thinking enabled for everything. The superior comprehension and tool-use ability leads to fewer mistakes and less rework. You end up saving more time overall by avoiding the debugging sessions that cheaper models create."

**Translation:** If you can afford it, Opus produces better results that save time downstream.

---

## Model Selection Matrix

Quick reference for common agent types:

| Agent Type | Recommended Model | Reason |
|------------|------------------|--------|
| **Planning** | Opus | Deep reasoning needed |
| **Architecture** | Opus | Complex decisions |
| **Security Review** | Opus | Critical analysis |
| **Code Review** | Sonnet | Good judgment |
| **Implementation** | Sonnet | Quality coding |
| **Build Fix** | Sonnet | Error diagnosis |
| **TDD Guide** | Sonnet | Test writing |
| **Documentation** | Sonnet | Clear writing |
| **Research** | Sonnet | Finding solutions |
| **Format Check** | Haiku | Simple validation |
| **Lint Runner** | Haiku | Run commands |
| **Import Sorter** | Haiku | Simple transformation |
| **Worker Agents** | Haiku | Parallel execution |

---

## Anthropic Recommendations

### From Claude Code Best Practices

**On model selection:**
> "Haiku 4.5 provides 90% of Sonnet capability at 3x cost savings. Use for lightweight agents with frequent invocation, pair programming, and worker agents in multi-agent systems."

**On when to use Opus:**
> "Use Opus 4.5 for complex architectural decisions and maximum reasoning requirements."

### From Claude Agent SDK

**On tool-use ability:**
> "The superior comprehension and tool-use ability of more capable models leads to fewer mistakes and less rework."

**Translation:** More capable models make better tool choices and produce better results.

---

## Model Switching Strategies

### Dynamic Model Selection

For agents that handle varying complexity:

```markdown
## Model Selection Logic

1. **Simple cases** (pattern matching, formatting)
   - Use Haiku for speed

2. **Standard cases** (typical bugs, features)
   - Use Sonnet (default)

3. **Complex cases** (architecture, security)
   - Upgrade to Opus
```

### Tiered Approach

```
Initial Analysis (Haiku) → Quick assessment
├── Simple → Haiku completes
├── Medium → Escalate to Sonnet
└── Complex → Escalate to Opus
```

### Cost-Conscious Strategy

For budget-constrained projects:

1. **Default to Sonnet** for most work
2. **Use Haiku** for:
   - Parallel worker agents
   - Validation tasks
   - Format checking
3. **Reserve Opus** for:
   - Critical architectural decisions
   - Security-sensitive code
   - Complex debugging

---

## Examples by Use Case

### High-Frequency Agent (Haiku)
```yaml
---
name: pr-label-checker
description: Checks PR labels and suggests corrections
tools: Read, Bash
model: haiku  # Runs on every PR, simple logic
---
```

### Standard Development Agent (Sonnet)
```yaml
---
name: feature-implementer
description: Implements features following project patterns
tools: Read, Write, Edit, Grep, Glob
model: sonnet  # Standard coding work
---
```

### Critical Decision Agent (Opus)
```yaml
---
name: migration-planner
description: Plans database migrations with rollback strategies
tools: Read, Grep, Glob
model: opus  # Migrations are high-risk
---
```

---

## Summary

### Quick Decision Guide

1. **Is this a simple, repetitive task?** → Haiku
2. **Is this standard development work?** → Sonnet
3. **Does this require deep reasoning?** → Opus
4. **Is this security/architecture critical?** → Opus
5. **Are many agents running in parallel?** → Haiku for workers
6. **Is quality more important than cost?** → Opus
7. **Unsure?** → Start with Sonnet, adjust based on results
