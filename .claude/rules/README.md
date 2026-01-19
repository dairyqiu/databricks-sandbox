# Hard Rules

**Critical guidelines that guide Claude's behavior across all projects**

This directory contains 7 hard rule files that establish mandatory practices for security, git workflow, code quality, testing, agent usage, performance, and common patterns.

---

## What Are Hard Rules?

Hard rules are **persistent guidelines** that Claude follows throughout your development session. Unlike skills (which activate contextually), rules are **always active** and guide decision-making across all tasks.

**Think of them as:**
- Your team's coding standards
- Best practices enforcement
- Security guardrails
- Quality gates

---

## Included Rules

### [security.md](security.md) - Security Guidelines

**Purpose:** Prevent common security vulnerabilities

**Key Requirements:**
- ✅ No hardcoded secrets (API keys, passwords, tokens)
- ✅ All user inputs validated
- ✅ SQL injection prevention (parameterized queries)
- ✅ XSS prevention (sanitized HTML)
- ✅ CSRF protection enabled
- ✅ Authentication/authorization verified
- ✅ Rate limiting on all endpoints
- ✅ Error messages don't leak sensitive data

**Enforcement:**
- Mandatory checks before ANY commit
- Security-reviewer agent available for analysis
- Blocks dangerous operations

**Example:**
```typescript
// NEVER: Hardcoded secrets
const apiKey = "sk-proj-xxxxx"

// ALWAYS: Environment variables
const apiKey = process.env.OPENAI_API_KEY
if (!apiKey) {
  throw new Error('OPENAI_API_KEY not configured')
}
```

---

### [git-workflow.md](git-workflow.md) - Git Workflow

**Purpose:** Maintain clean, traceable git history

**Key Requirements:**
- ✅ Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`, `perf:`, `ci:`
- ✅ No direct push to main/master
- ✅ PR review requirements
- ✅ Detailed commit messages
- ✅ Analyze full commit history for PRs (not just latest commit)

**Workflow:**
1. **Plan First** - Use planner agent for complex features
2. **TDD Approach** - Use tdd-guide agent, write tests first
3. **Code Review** - Use code-reviewer agent immediately after writing code
4. **Commit & Push** - Follow conventional commits format

**Example Commit Message:**
```
feat: add user authentication with JWT

Implements JWT-based authentication system with:
- Login/logout endpoints
- Token refresh mechanism
- Protected route middleware
- Session management

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

---

### [coding-style.md](coding-style.md) - Coding Standards

**Purpose:** Maintain readable, maintainable code

**Key Principles:**
- **Immutability** (CRITICAL) - Always create new objects, never mutate
- **Many small files > few large files** - 200-400 lines typical, 800 max
- **Proper error handling** - Comprehensive try/catch blocks
- **Input validation** - Always validate user input
- **No console.log** - Use proper logging
- **No hardcoded values** - Use constants or config

**Quality Checklist:**
- [ ] Code is readable and well-named
- [ ] Functions are small (<50 lines)
- [ ] Files are focused (<800 lines)
- [ ] No deep nesting (>4 levels)
- [ ] Proper error handling
- [ ] No console.log statements
- [ ] No hardcoded values
- [ ] No mutation (immutable patterns used)

**Example - Immutability:**
```javascript
// WRONG: Mutation
function updateUser(user, name) {
  user.name = name  // MUTATION!
  return user
}

// CORRECT: Immutability
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

---

### [testing.md](testing.md) - Testing Requirements

**Purpose:** Ensure code reliability through comprehensive testing

**Key Requirements:**
- ✅ **Minimum 80% test coverage**
- ✅ **TDD mandatory workflow** (RED → GREEN → REFACTOR)
- ✅ Unit tests (individual functions, components)
- ✅ Integration tests (API endpoints, database)
- ✅ E2E tests (critical user flows)

**TDD Workflow:**
1. Write test first (RED)
2. Run test - it should FAIL
3. Write minimal implementation (GREEN)
4. Run test - it should PASS
5. Refactor (IMPROVE)
6. Verify coverage (80%+)

**Agent Support:**
- **tdd-guide** - Use PROACTIVELY for new features
- **e2e-runner** - Playwright E2E testing specialist

---

### [agents.md](agents.md) - Agent Orchestration

**Purpose:** Guide when and how to use specialized agents

**Available Agents:**

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| planner | Implementation planning | Complex features, refactoring |
| architect | System design | Architectural decisions |
| tdd-guide | Test-driven development | New features, bug fixes |
| code-reviewer | Code review | After writing code |
| security-reviewer | Security analysis | Before commits |
| build-error-resolver | Fix build errors | When build fails |
| e2e-runner | E2E testing | Critical user flows |
| refactor-cleaner | Dead code cleanup | Code maintenance |
| doc-updater | Documentation | Updating docs |

**Immediate Usage** (no user prompt needed):
1. Complex feature requests → Use **planner** agent
2. Code just written/modified → Use **code-reviewer** agent
3. Bug fix or new feature → Use **tdd-guide** agent
4. Architectural decision → Use **architect** agent

**Parallel Execution:**
Always use parallel Task execution for independent operations.

---

### [performance.md](performance.md) - Performance Optimization

**Purpose:** Optimize Claude Code usage for cost and efficiency

**Model Selection Strategy:**

**Haiku 4.5** (90% of Sonnet capability, 3x cost savings):
- Lightweight agents with frequent invocation
- Pair programming and code generation
- Worker agents in multi-agent systems

**Sonnet 4.5** (Best coding model):
- Main development work
- Orchestrating multi-agent workflows
- Complex coding tasks

**Opus 4.5** (Deepest reasoning):
- Complex architectural decisions
- Maximum reasoning requirements
- Research and analysis tasks

**Context Window Management:**
- Avoid last 20% of context window for large-scale changes
- Use lower context sensitivity for single-file edits

**Complex Tasks:**
1. Use `ultrathink` for enhanced thinking
2. Enable **Plan Mode** for structured approach
3. "Rev the engine" with multiple critique rounds
4. Use split role sub-agents for diverse analysis

---

### [patterns.md](patterns.md) - Common Patterns

**Purpose:** Provide reusable patterns for common scenarios

**Included Patterns:**

**API Response Format:**
```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}
```

**Custom Hooks Pattern:**
```typescript
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay)
    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}
```

**Repository Pattern:**
```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}
```

**Skeleton Projects:**
When implementing new functionality:
1. Search for battle-tested skeleton projects
2. Use parallel agents to evaluate options
3. Clone best match as foundation
4. Iterate within proven structure

---

## How Rules Work

### Active Throughout Session

Rules are **always loaded** in Claude's context. They guide behavior without needing explicit activation.

**Unlike skills:**
- Skills activate based on triggers (keywords, file paths)
- Rules are always present and influencing decisions

**Unlike agents:**
- Agents handle specific sub-tasks autonomously
- Rules guide the main Claude instance continuously

### Enforcement Levels

**Rules provide guidelines, not strict enforcement.**

For strict enforcement, use:
1. **Skill enforcement** - Set `"enforcement": "block"` in skill-rules.json
2. **PreToolUse hooks** - Block operations before execution
3. **Agents** - code-reviewer, security-reviewer for validation

### Customization

**Rules are markdown files** - edit them to match your team's standards:

```bash
# Update security requirements
vim .claude/rules/security.md

# Adjust coding style preferences
vim .claude/rules/coding-style.md

# Modify testing coverage threshold
vim .claude/rules/testing.md
```

---

## Best Practices

### 1. Keep Rules Concise

- Focus on **what** and **why**, not exhaustive **how**
- Provide examples for clarity
- Link to detailed documentation when needed

### 2. Review and Update Regularly

- Rules should evolve with your team's practices
- Update when adopting new technologies or patterns
- Remove outdated guidelines

### 3. Align Rules with Skills

**Example:**
- **Rule:** "Always validate user input" (security.md)
- **Skill:** Provides specific validation patterns for your backend framework

Rules set the standard, skills provide the implementation details.

### 4. Use Rules for Critical Areas

**Good candidates for rules:**
- Security requirements (prevent vulnerabilities)
- Git workflow (maintain clean history)
- Code quality (readability, maintainability)
- Testing standards (ensure reliability)

**Not good for rules:**
- Framework-specific patterns (use skills instead)
- Project-specific details (use project documentation)
- Frequently changing conventions

---

## Integration with Other Components

### Rules + Skills

**Rules** define the standards (e.g., "Use TDD")
**Skills** provide the implementation (e.g., backend-dev-guidelines shows how to write tests for Express routes)

### Rules + Agents

**Rules** guide when to use agents (e.g., "Use code-reviewer after writing code")
**Agents** execute the validation (e.g., code-reviewer checks compliance with rules)

### Rules + Hooks

**Rules** establish the practice (e.g., "No console.log in production")
**Hooks** enforce the practice (e.g., PostToolUse hook detects console.log after edits)

---

## Example Rule Configuration

### Strict TDD Project

Update [testing.md](testing.md):
```markdown
# Testing Requirements

## Minimum Test Coverage: 90%  (increased from 80%)

## MANDATORY: Write Tests FIRST
- No implementation without failing test
- Use tdd-guide agent for ALL new features
- Block commits without 90%+ coverage
```

Add to skill-rules.json:
```json
{
  "tdd-workflow": {
    "enforcement": "block",  // BLOCKS if test not written first
    "priority": "critical"
  }
}
```

### Security-Critical Application

Update [security.md](security.md):
```markdown
# Security Guidelines

## CRITICAL: Before ANY commit

- [ ] Use security-reviewer agent
- [ ] All CRITICAL issues resolved
- [ ] All HIGH issues resolved or documented
- [ ] Dependency vulnerability scan passed
```

Add PreToolUse hook to block commits without security review.

### High-Performance Requirements

Update [performance.md](performance.md):
```markdown
# Performance Optimization

## Required Benchmarks

- API response time <200ms (p95)
- Database queries <50ms (p95)
- Bundle size <500KB (gzipped)

Use build-error-resolver agent for performance issues.
```

---

## Troubleshooting

### Rules Not Being Followed

**Problem:** Claude isn't following guidelines in rules/

**Remember:** Rules are guidelines, not strict enforcement.

**Solutions:**

1. **Use skill enforcement** for strict requirements:
   ```json
   "enforcement": "block"
   ```

2. **Add validation hooks** (PreToolUse, PostToolUse)

3. **Use review agents** after code is written:
   - code-reviewer
   - security-reviewer

4. **Be explicit in prompts** when you want strict adherence:
   ```
   "Following the security.md rules strictly, implement user authentication"
   ```

### Rules Conflicting

**Problem:** Rules contradict each other or skills

**Solutions:**

1. **Review all rules** for consistency
2. **Prioritize critical rules** (security > style)
3. **Update outdated rules** to align with current practices
4. **Remove conflicting requirements**

### Too Many Rules

**Problem:** Context is bloated with rules

**Solution:** Keep rules focused on **critical areas only**:
- Security (prevent vulnerabilities)
- Git workflow (maintain history)
- Core quality standards (readability, testing)

Move framework-specific details to skills.

---

## File Structure

```
rules/
├── security.md           # Security guidelines
├── git-workflow.md       # Git and commit standards
├── coding-style.md       # Code quality and style
├── testing.md            # Testing requirements
├── agents.md             # Agent orchestration
├── performance.md        # Performance optimization
├── patterns.md           # Common patterns
└── README.md             # This file
```

---

## Learn More

- **Main guide:** [../../README.md](../../README.md)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Skills system:** [../skills/README.md](../skills/README.md)
- **Agents system:** [../agents/README.md](../agents/README.md)
- **Hooks system:** [../hooks/README.md](../hooks/README.md)
