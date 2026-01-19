# Universal Agents

Twelve agents useful across ALL project types - AI research, web apps, Mac apps, data science, etc.

---

## What's Included

This directory contains **12 universal agents** that work regardless of tech stack:

### Planning & Architecture (3 agents)
1. **planner** - Four-phase implementation planning for complex features
2. **architect** - System design and architectural decision-making
3. **plan-reviewer** - Review development plans before implementation

### Code Quality (4 agents)
4. **code-reviewer** - Comprehensive code review with severity levels
5. **code-architecture-reviewer** - Review code for architectural consistency
6. **refactor-planner** - Create detailed refactoring strategies
7. **code-refactor-master** - Plan and execute refactoring

### Security & Testing (2 agents)
8. **security-reviewer** - Security vulnerability analysis (OWASP Top 10)
9. **tdd-guide** - Test-driven development enforcement

### Build & Documentation (2 agents)
10. **build-error-resolver** - Build and compilation error troubleshooting
11. **documentation-architect** - Generate comprehensive documentation

### Research (1 agent)
12. **web-research-specialist** - Research technical issues online

These agents are **standalone** - just use them. No customization needed.

**Philosophy:** These agents provide value across ALL project types. Domain-specific agents (like auth-route-tester) remain in optional-components.

---

## Agent Distinctions

Some agents have similar names but serve **complementary purposes**. Here's when to use each:

### Code Review Agents

**code-reviewer** vs **code-architecture-reviewer**
- **code-reviewer**: Line-level code quality (readability, maintainability, bugs, edge cases)
  - Use after: Small changes, bug fixes, feature additions
  - Focuses on: Code smells, error handling, naming, tests

- **code-architecture-reviewer**: System-level patterns (consistency, architecture alignment)
  - Use after: Major features, structural changes, new modules
  - Focuses on: Design patterns, coupling, separation of concerns

**When to use both:** After major features, run code-reviewer first for quality, then code-architecture-reviewer for system integration.

### Refactoring Agents

**refactor-planner** vs **code-refactor-master**
- **refactor-planner**: Creates refactoring strategy
  - Use when: Planning refactoring approach
  - Output: Analysis, plan, risk assessment, step-by-step strategy
  - Does not: Execute the refactoring

- **code-refactor-master**: Executes refactoring plan
  - Use when: Ready to refactor
  - Does: File moves, import updates, component extraction, code reorganization
  - Requires: Clear plan (from refactor-planner or user)

**Typical workflow:** refactor-planner → (review plan) → code-refactor-master → code-reviewer

### Planning Agents

**planner** vs **architect** vs **plan-reviewer**
- **planner**: Four-phase implementation planning
  - Use for: Feature implementation, complex tasks
  - Focus: Step-by-step execution plan
  - Output: Detailed implementation steps, file changes, testing approach

- **architect**: High-level system design decisions
  - Use for: Choosing technologies, design patterns, scalability
  - Focus: System architecture, trade-offs, best practices
  - Output: Architectural recommendations with justifications

- **plan-reviewer**: Validates plans before implementation
  - Use for: Reviewing any development plan
  - Focus: Finding issues, missing considerations, alternatives
  - Output: Plan critique, suggestions, risk identification

**Typical workflow:** architect (design) → planner (implementation) → plan-reviewer (validation) → execute

---

## Agent Descriptions

### Planning & Architecture Agents

#### planner

**Use when:** You have a complex feature to implement and need a comprehensive plan.

**What it does:**
- Four-phase planning (Understanding → Analysis → Design → Validation)
- Breaks down complex tasks
- Considers dependencies and risks
- Provides step-by-step implementation approach
- Uses Opus model for deep reasoning

**Example:**
```
User: "Add user authentication to the app"
Assistant: Uses planner agent for four-phase implementation plan
```

#### architect

**Use when:** You need to make system design decisions or choose between architectural approaches.

**What it does:**
- Evaluates design patterns
- Recommends architectural solutions
- Considers scalability and maintainability
- Analyzes trade-offs between approaches
- Provides technical justification

**Example:**
```
User: "Should we use REST or GraphQL for our API?"
Assistant: Uses architect agent to evaluate approaches
```

#### plan-reviewer

**Use when:** You have a development plan that needs review before implementation.

**What it does:**
- Analyzes proposed plans
- Identifies potential issues
- Suggests missing considerations
- Evaluates alternative approaches
- Validates assumptions

**Example:**
```
User: "Review this plan before I start implementation"
Assistant: Uses plan-reviewer to analyze and provide feedback
```

### Code Quality Agents

#### code-reviewer

**Use when:** You've written code and want comprehensive review with severity levels.

**What it does:**
- Reviews code for quality and security
- Categorizes issues (CRITICAL, HIGH, MEDIUM, LOW)
- Checks best practices
- Identifies potential bugs
- Suggests improvements

**Example:**
```
User: "Review this authentication implementation"
Assistant: Uses code-reviewer for comprehensive analysis
```

### code-architecture-reviewer

**Use when:** You've written code and want to ensure it follows best practices and architectural patterns.

**What it does:**
- Reviews recent code changes
- Questions implementation decisions
- Checks alignment with project standards
- Suggests architectural improvements
- Identifies potential issues

**Example:**
```
User: "I've added a new workflow status endpoint"
Assistant: Uses code-architecture-reviewer agent to review the implementation
```

### code-refactor-master

**Use when:** You need to refactor code for better organization, cleaner architecture, or improved maintainability.

**What it does:**
- Analyzes current code structure
- Breaks down large components
- Updates import paths after moves
- Fixes loading indicator patterns
- Ensures consistency across codebase

**Example:**
```
User: "This components folder is a mess with huge files"
Assistant: Uses code-refactor-master to analyze and reorganize
```

### documentation-architect

**Use when:** You need to create or update documentation for any part of the codebase.

**What it does:**
- Gathers context from memory and files
- Creates developer documentation
- Generates API documentation
- Creates data flow diagrams
- Updates README files

**Example:**
```
User: "Document the authentication system"
Assistant: Uses documentation-architect to create comprehensive docs
```

### plan-reviewer

**Use when:** You have a development plan that needs review before implementation.

**What it does:**
- Analyzes proposed plans
- Identifies potential issues
- Suggests missing considerations
- Evaluates alternative approaches
- Validates assumptions

**Example:**
```
User: "Review this plan before I start implementation"
Assistant: Uses plan-reviewer to analyze and provide feedback
```

### refactor-planner

**Use when:** You need to analyze code and create a comprehensive refactoring plan.

**What it does:**
- Analyzes current code structure
- Identifies improvement opportunities
- Creates step-by-step refactoring plans
- Assesses risks
- Considers architectural trade-offs

**Example:**
```
User: "I need to refactor our authentication module"
Assistant: Uses refactor-planner to create a detailed plan
```

### Security & Testing Agents

#### security-reviewer

**Use when:** You need security vulnerability analysis before commits or for security-critical code.

**What it does:**
- Analyzes code for OWASP Top 10 vulnerabilities
- Checks authentication and authorization
- Validates input sanitization
- Identifies injection risks (SQL, XSS, etc.)
- Reviews secret management

**Example:**
```
User: "Check this payment processing code for security issues"
Assistant: Uses security-reviewer for vulnerability analysis
```

#### tdd-guide

**Use when:** Implementing new features or fixing bugs using test-driven development.

**What it does:**
- Enforces RED → GREEN → REFACTOR cycle
- Guides test-first development
- Ensures 80%+ test coverage
- Reviews test quality
- Helps debug test failures

**Example:**
```
User: "Add a new user registration feature"
Assistant: Uses tdd-guide to enforce test-first development
```

### Build & Documentation Agents

#### build-error-resolver

**Use when:** Your build fails with compilation or build errors.

**What it does:**
- Analyzes build error messages
- Diagnoses root causes
- Suggests fixes incrementally
- Verifies fixes work
- Handles TypeScript, bundling, and compilation errors

**Example:**
```
User: "The build is failing with TypeScript errors"
Assistant: Uses build-error-resolver to diagnose and fix
```

### Research Agents

#### web-research-specialist

**Use when:** You need to research technical issues, debug problems, or gather information from the internet.

**What it does:**
- Searches GitHub issues, Reddit, Stack Overflow
- Finds relevant discussions and solutions
- Compiles findings from multiple sources
- Uses creative search strategies
- Provides comprehensive summaries

**Example:**
```
User: "I'm getting a 'Module not found' error with webpack"
Assistant: Uses web-research-specialist to find solutions
```

---

## How to Use Agents

Agents are invoked automatically by Claude when tasks match their descriptions. You can also explicitly request them:

```
"Use the code-architecture-reviewer agent to review my UserService class"
```

Or Claude will suggest:
```
"Let me use the refactor-planner agent to create a refactoring strategy"
```

---

## Optional Specialized Agents

See [optional-components/agents/README.md](../../optional-components/agents/README.md) for **7 specialized agents** (domain-specific and advanced use cases):

### Testing
- **e2e-runner** - Playwright E2E test execution

### Debugging
- **frontend-error-fixer** - Debug frontend build and runtime errors
- **auto-error-resolver** - Auto-fix TypeScript compilation errors
- **auth-route-debugger** - Debug JWT authentication issues

### Maintenance
- **refactor-cleaner** - Dead code identification and removal
- **doc-updater** - Documentation synchronization with code

### Domain-Specific
- **auth-route-tester** - Test authenticated endpoints (JWT cookie auth)

**Note:** The 6 most universal agents (planner, architect, code-reviewer, security-reviewer, tdd-guide, build-error-resolver) have been moved to the base template above.

---

## Agent vs Skill

**When to use an Agent:**
- Complex, multi-step tasks
- Need autonomous execution
- Task requires specific tools/workflow
- Want specialized expertise

**When to use a Skill:**
- Ongoing guidance/patterns
- Domain knowledge reference
- Code examples and best practices
- Persistent throughout session

**Example:**
- Use **backend-patterns skill** for API design patterns
- Use **planner agent** to plan implementing a specific API feature

---

## Adding Optional Agents

To use specialized agents from [optional-components/agents/](../../optional-components/agents/):

```bash
# Example: Copy e2e-runner for Playwright testing
cp optional-components/agents/testing/e2e-runner.md .claude/agents/

# That's it! Agent is now available
```

No configuration needed - agents are self-contained.

**When to add optional agents:**
- **e2e-runner**: When using Playwright for E2E testing
- **frontend-error-fixer**: For frontend-heavy projects (React, etc.)
- **auto-error-resolver**: For large TypeScript codebases
- **auth-route-tester**: For Express APIs with JWT auth
- **doc-updater**: When maintaining extensive documentation

---

## Agent Capabilities

### Autonomous Execution

Agents run independently with:
- Full conversation context
- Access to all tools
- Ability to make multi-step decisions
- Return final result when done

### Tool Access

Most agents have access to:
- File reading (Glob, Grep, Read)
- Code editing (Edit, Write)
- Web research (WebFetch, WebSearch)
- Bash commands
- Task delegation (can launch sub-agents)

### Model Selection

Some agents specify models:
- **planner** uses Opus for complex planning
- Most use Sonnet for balanced performance
- Can be customized in agent .md file

---

## File Structure

```
agents/
├── planner.md                        # NEW: Four-phase planning (Opus)
├── architect.md                      # NEW: System design
├── plan-reviewer.md
├── code-reviewer.md                  # NEW: Comprehensive review
├── code-architecture-reviewer.md
├── refactor-planner.md
├── code-refactor-master.md
├── security-reviewer.md              # NEW: Security analysis
├── tdd-guide.md                      # NEW: Test-driven development
├── build-error-resolver.md           # NEW: Build troubleshooting
├── documentation-architect.md
├── web-research-specialist.md
└── README.md                         # This file
```

**Total: 12 universal agents**

---

## Customization

Agents are markdown files with YAML frontmatter. To customize:

1. Copy agent to your `.claude/agents/` directory
2. Edit the markdown file
3. Modify the agent's instructions, tools, or behavior

**Example agent structure:**
```markdown
---
name: agent-name
description: What this agent does
tools: [Read, Edit, Bash, ...]
model: sonnet
---

# Agent Instructions

Your custom instructions here...
```

---

## Best Practices

### Use Agents Proactively

Don't wait for users to ask - delegate when appropriate:
- Code review after implementing features
- Planning before major changes
- Research when encountering errors

### Parallel Execution

Launch multiple independent agents in parallel:
```
"I'll launch the code-architecture-reviewer and documentation-architect agents in parallel"
```

### Agent Chaining

Use agents sequentially for complex workflows:
1. **refactor-planner** creates plan
2. **plan-reviewer** reviews it
3. **code-refactor-master** executes it
4. **code-architecture-reviewer** verifies result

---

## Troubleshooting

### Agent not activating

- Agents auto-activate based on task descriptions
- Try explicitly requesting: "Use the [agent-name] agent"
- Check agent file exists in `.claude/agents/`

### Agent errors

- Review agent .md file for correct format
- Check YAML frontmatter is valid
- Verify tools specified are available

### Agent not helpful

- May need customization for your use case
- Try different agent for same task
- Provide more context in request

---

## Learn More

- **Optional agents:** [../../optional-components/agents/README.md](../../optional-components/agents/README.md)
- **Skills vs Agents:** [../skills/README.md](../skills/README.md)
- **Main guide:** [../../README.md](../../README.md)
