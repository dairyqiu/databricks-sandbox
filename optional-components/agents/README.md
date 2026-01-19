# Optional Specialized Agents

**Domain-specific agents to copy into your project as needed**

**Note:** 6 universal agents (planner, architect, code-reviewer, security-reviewer, tdd-guide, build-error-resolver) have been moved to the base template at `.claude/agents/`.

This directory contains the remaining **7 specialized agents** organized by category. These agents handle domain-specific tasks like E2E testing, frontend debugging, and JWT authentication testing.

---

## Quick Reference

### Universal Agents (Now in Base Template)

These agents have been moved to `.claude/agents/` and are available in all projects:
- **planner** - Four-phase feature planning (Opus)
- **architect** - System design decisions
- **code-reviewer** - Code quality review
- **security-reviewer** - Vulnerability analysis
- **tdd-guide** - Test-driven development
- **build-error-resolver** - Build troubleshooting

See [../../.claude/agents/README.md](../../.claude/agents/README.md) for details.

### Specialized Agents (This Directory)

| Category | Agent | Purpose | Location |
|----------|-------|---------|----------|
| **Testing** | [e2e-runner](#e2e-runner) | Playwright E2E testing | `testing/` |
| **Debugging** | [frontend-error-fixer](#frontend-error-fixer) | Fix frontend build/runtime errors | `debugging/` |
| **Debugging** | [auto-error-resolver](#auto-error-resolver) | Auto-fix TypeScript errors | `debugging/` |
| **Debugging** | [auth-route-debugger](#auth-route-debugger) | Debug authentication issues | `debugging/` |
| **Maintenance** | [refactor-cleaner](#refactor-cleaner) | Dead code identification | `maintenance/` |
| **Maintenance** | [doc-updater](#doc-updater) | Documentation synchronization | `maintenance/` |
| **Domain-Specific** | [auth-route-tester](#auth-route-tester) | Test authenticated endpoints | `domain-specific/` |

---

## Testing

### e2e-runner

**Purpose:** Playwright end-to-end testing specialist.

**Use When:**
- Testing critical user flows
- Regression testing
- Debugging E2E test failures
- Creating new E2E tests

**What It Does:**
- Writes Playwright tests
- Runs E2E test suites
- Debugs test failures
- Provides test recommendations
- Handles browser interactions

**Tech Stack Requirements:**
- Playwright installed
- E2E test setup

**Integration:**

```bash
cp optional-components/agents/testing/e2e-runner.md .claude/agents/
```

**Example Usage:**
```
User: "Test the checkout flow end-to-end"
Assistant: "I'll use the e2e-runner agent to create and run E2E tests"
```

---

## Debugging

### frontend-error-fixer

**Purpose:** Diagnose and fix frontend errors, whether build-time (TypeScript, bundling) or runtime (browser console).

**Use When:**
- TypeScript compilation errors
- Build process failing
- Runtime errors in browser console
- React component errors
- Network issues
- Module resolution problems

**What It Does:**
- Analyzes error messages
- Identifies root cause
- Provides fix recommendations
- Can use browser tools MCP for runtime debugging
- Handles both build and runtime errors

**Tech Stack Requirements:**
- Frontend framework (React, Vue, etc.)
- TypeScript
- Module bundler (Webpack, Vite, etc.)

**Integration:**

```bash
cp optional-components/agents/debugging/frontend-error-fixer.md .claude/agents/
```

**Example Usage:**
```
User: "My build is failing with a TypeScript error about missing types"
Assistant: "Let me use the frontend-error-fixer agent to resolve this build error"
```

**Customization Needed:**
- Update screenshot paths for your system
- Adjust for your bundler configuration
- Modify for your framework-specific errors

---

### auto-error-resolver

**Purpose:** Automatically fix TypeScript compilation errors in your codebase.

**Use When:**
- Multiple TypeScript errors after refactoring
- Type mismatches across files
- Upgrading TypeScript or dependencies
- Batch error fixing needed

**What It Does:**
- Reads TypeScript errors from build output
- Identifies fix patterns
- Applies fixes using Edit/Write tools
- Runs build again to verify
- Iterates until errors resolved

**Tech Stack Requirements:**
- TypeScript project
- `tsc` or similar type checker

**Integration:**

```bash
cp optional-components/agents/debugging/auto-error-resolver.md .claude/agents/
```

**Example Usage:**
```
User: "Fix all the TypeScript errors in the codebase"
Assistant: [Automatically uses auto-error-resolver agent]
```

**Customization Needed:**
- Adjust for your tsconfig.json location
- Update build command if not using `tsc`
- Modify fix patterns for your conventions

---

### auth-route-debugger

**Purpose:** Debug authentication-related issues with API routes, including 401/403 errors, cookie problems, and route registration.

**Use When:**
- Getting 401/403 errors despite being logged in
- Routes returning 404 but are defined
- Cookie/JWT token issues
- Authentication middleware not working
- Route registration conflicts

**What It Does:**
- Diagnoses authentication flow issues
- Checks JWT token validation
- Verifies cookie configuration
- Tests route registration
- Identifies middleware ordering problems
- Provides fix recommendations

**Tech Stack Requirements:**
- Keycloak or similar auth provider
- JWT cookie-based authentication
- Express or similar framework

**Integration:**

```bash
cp optional-components/agents/debugging/auth-route-debugger.md .claude/agents/
```

**Example Usage:**
```
User: "I'm getting a 401 error when trying to access /api/workflow/123"
Assistant: "I'll use the auth-route-debugger agent to investigate this authentication issue"
```

**Customization Needed:**
- Update for your auth provider (if not Keycloak)
- Adjust cookie handling patterns
- Modify for your routing system

---

## Maintenance

### refactor-cleaner

**Purpose:** Identify and remove dead code, unused imports, and technical debt.

**Use When:**
- Code cleanup needed
- After major refactoring
- Removing unused features
- Reducing bundle size

**What It Does:**
- Scans for unused exports
- Identifies dead code paths
- Finds unused imports
- Locates deprecated patterns
- Suggests safe removals

**Integration:**

```bash
cp optional-components/agents/maintenance/refactor-cleaner.md .claude/agents/
```

**Example Usage:**
```
User: "Clean up unused code in the project"
Assistant: "Let me use the refactor-cleaner agent to identify dead code"
```

---

### doc-updater

**Purpose:** Keep documentation synchronized with code changes.

**Use When:**
- After API changes
- After feature implementation
- Documentation drift detected
- README needs updating

**What It Does:**
- Compares code to documentation
- Identifies outdated docs
- Updates documentation files
- Maintains consistency
- Suggests improvements

**Integration:**

```bash
cp optional-components/agents/maintenance/doc-updater.md .claude/agents/
```

**Example Usage:**
```
User: "Update the API documentation after my changes"
Assistant: "I'll use the doc-updater agent to synchronize the documentation"
```

---

## Domain-Specific

### auth-route-tester

**Purpose:** Test routes after implementing or modifying them, focusing on complete route functionality with JWT cookie authentication.

**Use When:**
- Just implemented a new POST/GET/PUT/DELETE route
- Modified existing route logic
- Added authentication to routes
- Need to verify database record creation

**What It Does:**
- Tests route with proper authentication (JWT cookies)
- Verifies database records are created correctly
- Checks response format and status codes
- Reviews route implementation for improvements
- Ensures authentication middleware works

**Tech Stack Requirements:**
- JWT cookie-based authentication
- REST API routes
- Database (Prisma or similar)

**Integration:**

```bash
cp optional-components/agents/domain-specific/auth-route-tester.md .claude/agents/
```

**Example Usage:**
```
User: "I've added a new POST route to /form/submit that creates submissions"
Assistant: "Let me use the auth-route-tester agent to verify the route functionality"
```

**Customization Needed:**
- Update authentication cookie names
- Adjust for your JWT token structure
- Modify for your database ORM

---

## Integration Guide

### Copy Single Agent

```bash
# Example: Adding E2E testing
cp optional-components/agents/testing/e2e-runner.md .claude/agents/
```

Agents are **self-contained** - no configuration needed.

### Copy Multiple Agents by Category

**For Frontend Projects:**

```bash
# Debugging
cp optional-components/agents/debugging/frontend-error-fixer.md .claude/agents/
cp optional-components/agents/debugging/auto-error-resolver.md .claude/agents/

# Testing
cp optional-components/agents/testing/e2e-runner.md .claude/agents/

# Maintenance
cp optional-components/agents/maintenance/doc-updater.md .claude/agents/
```

**For Backend API Projects:**

```bash
# Debugging
cp optional-components/agents/debugging/auth-route-debugger.md .claude/agents/

# Domain-specific
cp optional-components/agents/domain-specific/auth-route-tester.md .claude/agents/

# Maintenance
cp optional-components/agents/maintenance/refactor-cleaner.md .claude/agents/
cp optional-components/agents/maintenance/doc-updater.md .claude/agents/
```

### Copy All Optional Agents

```bash
# Copy all specialized agents
cp optional-components/agents/testing/*.md .claude/agents/
cp optional-components/agents/debugging/*.md .claude/agents/
cp optional-components/agents/maintenance/*.md .claude/agents/
cp optional-components/agents/domain-specific/*.md .claude/agents/
```

---

## Agent Usage Patterns

### When to Use Optional Agents

**Use these agents when you need domain-specific functionality:**

**E2E Testing (e2e-runner):**
- Critical user flows need testing
- Regression testing is required
- Using Playwright for E2E tests

**Frontend Debugging (frontend-error-fixer, auto-error-resolver):**
- Frontend build errors
- TypeScript compilation issues
- React/Vue component errors
- Multiple type errors to fix

**API Authentication (auth-route-tester, auth-route-debugger):**
- Testing JWT authenticated routes
- Debugging 401/403 errors
- Cookie-based authentication issues
- Route registration problems

**Code Maintenance (refactor-cleaner, doc-updater):**
- Dead code cleanup needed
- Documentation is out of sync
- Reducing bundle size
- Technical debt removal

### Sequential Workflows with Optional Agents

**Feature Implementation (Frontend):**
1. planner (base) - Create implementation plan
2. tdd-guide (base) - Implement with TDD
3. code-reviewer (base) - Review implementation
4. **e2e-runner** (optional) - Add E2E tests for critical flows
5. **doc-updater** (optional) - Update documentation

**Bug Fix (Backend API):**
1. **auth-route-debugger** (optional) - Diagnose auth issue
2. tdd-guide (base) - Write failing test
3. Fix the bug
4. **auth-route-tester** (optional) - Test authenticated route
5. code-reviewer (base) - Review fix

**Refactoring (TypeScript Project):**
1. code-reviewer (base) - Review before refactoring
2. Perform refactoring
3. **auto-error-resolver** (optional) - Fix TypeScript errors
4. **refactor-cleaner** (optional) - Clean up dead code
5. **doc-updater** (optional) - Update docs

---

## Customization

### Adapting for Your Stack

Most specialized agents need customization for your specific tech stack:

**auth-route-tester & auth-route-debugger:**
- Update authentication patterns for your auth provider
- Modify cookie handling for your cookie names
- Adjust database queries for your ORM
- Update route patterns for your framework

**frontend-error-fixer:**
- Update screenshot paths for your OS
- Adjust for your bundler (Webpack, Vite, Rollup, etc.)
- Modify framework-specific error patterns (React, Vue, Svelte, etc.)

**auto-error-resolver:**
- Update tsconfig.json path
- Modify build command (tsc, tsx, etc.)
- Adjust fix patterns for your code style

**e2e-runner:**
- Update Playwright configuration path
- Adjust selectors for your app structure
- Modify test patterns for your routing

### Creating Custom Specialized Agents

Use the agent template structure:

```markdown
---
name: custom-specialized-agent
description: What this agent does
tools: [Read, Edit, Write, Bash, Grep, Glob]
model: sonnet
---

# Agent Instructions

## Purpose
[Describe what this agent does]

## When to Use
[List specific scenarios]

## Process
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Tech Stack Assumptions
[List any framework/tool dependencies]

## Example
[Provide usage example]
```

---

## Agent vs Skill vs Rule

**Specialized Agent (these):**
- Domain-specific sub-task execution
- Requires specific tech stack (Playwright, JWT auth, etc.)
- Optional - add only if using that tech
- Example: "Test this JWT authenticated route"

**Universal Agent (in base):**
- Generic sub-task execution
- Works across all project types
- Always available in base template
- Example: "Review this code for quality issues"

**Skill:**
- Contextual guidance throughout session
- Framework-specific patterns and examples
- Activated by triggers (keywords, files)
- Example: "Backend development patterns"

**Rule:**
- Always-active guideline
- Influences all decisions
- Not task or tech-specific
- Example: "Always validate user input"

---

## Best Practices

### 1. Add Only What You Need

Don't copy all optional agents - add only those relevant to your tech stack:

**Using Playwright?** → Add e2e-runner
**JWT authentication?** → Add auth-route-tester, auth-route-debugger
**Large TypeScript codebase?** → Add auto-error-resolver
**Frontend project?** → Add frontend-error-fixer

### 2. Combine with Universal Agents

Specialized agents work best alongside universal agents:

```
# Universal workflow
planner → tdd-guide → code-reviewer → security-reviewer

# Add specialized agents as needed
+ e2e-runner (if critical user flow)
+ auth-route-tester (if authenticated API)
+ doc-updater (if public API)
```

### 3. Customize for Your Stack

**Before using:**
1. Read agent's "Customization Needed" section
2. Update tech stack assumptions
3. Adjust paths, commands, and patterns
4. Test with a simple use case

### 4. Use Appropriate Model

All optional agents use **Sonnet** by default, which is appropriate for most specialized tasks.

**Change to Haiku if:**
- Task is very simple and repetitive
- Agent runs frequently
- Cost optimization is priority

**Change to Opus if:**
- Task requires deep reasoning
- Complexity is very high
- Quality is more important than cost

---

## Troubleshooting

### Agent Not Activating

**Problem:** Agent doesn't run when expected

**Solutions:**
1. **Verify agent file exists**: `ls .claude/agents/agent-name.md`
2. **Check YAML frontmatter** is valid
3. **Explicitly request**: "Use the e2e-runner agent"
4. **Ensure tech stack matches** agent requirements

### Agent Produces Errors

**Problem:** Agent execution fails with tool errors

**Solutions:**
1. **Check tech stack is installed** (Playwright, tsc, etc.)
2. **Verify paths in agent** match your project structure
3. **Update agent customization** for your setup
4. **Check permissions** for file operations

### Agent Results Not Helpful

**Problem:** Agent output doesn't solve your issue

**Solutions:**
1. **Verify tech stack compatibility** - agent may assume different framework
2. **Customize agent** for your specific setup
3. **Provide more context** when invoking
4. **Try universal agent** if domain-specific isn't working

---

## Learn More

- **Universal agents:** [../../.claude/agents/README.md](../../.claude/agents/README.md)
- **Agent orchestration rules:** [../../.claude/rules/agents.md](../../.claude/rules/agents.md)
- **Main guide:** [../../README.md](../../README.md)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
