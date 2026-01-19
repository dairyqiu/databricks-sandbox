# Optional Skills

**Domain-specific skills to copy into your project as needed**

This directory contains 11 optional skills covering backend, frontend, testing, security, and specialized domains. Copy only what you need for your project's tech stack.

---

## Quick Reference

| Skill | Source | Use For | Size |
|-------|--------|---------|------|
| [backend-dev-guidelines](#backend-dev-guidelines) | Original | Node.js/Express/Prisma | Modular (12 resources) |
| [frontend-dev-guidelines](#frontend-dev-guidelines) | Original | React/MUI v7 | Modular (8 resources) |
| [route-tester](#route-tester) | Original | JWT cookie auth testing | Single file |
| [error-tracking](#error-tracking) | Original | Sentry integration | Single file |
| [backend-patterns](#backend-patterns) | everything-claude-code | API design, caching | Single file |
| [frontend-patterns](#frontend-patterns) | everything-claude-code | React composition, hooks | Single file |
| [coding-standards](#coding-standards) | everything-claude-code | TypeScript, naming | Single file |
| [tdd-workflow](#tdd-workflow) | everything-claude-code | Test-driven development | Modular (3 resources) |
| [security-review](#security-review) | everything-claude-code | Security checklist | Modular (2 resources) |
| [clickhouse-io](#clickhouse-io) | everything-claude-code | Analytics queries | Single file |
| [project-guidelines-example](#project-guidelines-example) | everything-claude-code | Template for custom | Single file |

---

## From Original Repository

### backend-dev-guidelines

**Tech Stack:** Node.js, Express.js, Prisma ORM, TypeScript

**Size:** Modular (SKILL.md + 12 resource files, follows 500-line rule)

**Coverage:**
- Express routing patterns
- Controller organization
- Service layer architecture
- Prisma database integration
- JWT authentication (cookie-based)
- Error handling middleware
- Testing patterns for backend
- Repository pattern
- Dependency injection
- API documentation
- Validation with Zod
- Background jobs

**When to Use:**
- Building Node.js APIs
- Using Express.js framework
- Working with Prisma ORM
- Implementing authentication

**Integration:**

```bash
# 1. Copy the skill
cp -r optional-components/skills/backend-dev-guidelines/ .claude/skills/

# 2. Add to skill-rules.json
```

Add to [.claude/skills/skill-rules.json](../../.claude/skills/skill-rules.json):

```json
{
  "backend-dev-guidelines": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "high",
    "description": "Node.js/Express/Prisma development patterns",
    "promptTriggers": {
      "keywords": [
        "backend",
        "API",
        "route",
        "controller",
        "service",
        "Express",
        "Prisma",
        "endpoint",
        "middleware"
      ],
      "intentPatterns": [
        "(create|add|implement).*?(route|endpoint|API|controller)",
        "(backend|server).*?(development|pattern|guide)",
        "(add|create).*?(service|middleware)"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "backend/**/*.ts",
        "api/**/*.ts",
        "src/routes/**/*.ts",
        "src/controllers/**/*.ts",
        "src/services/**/*.ts"
      ],
      "contentPatterns": [
        "router\\.",
        "export.*Controller",
        "export.*Service",
        "prisma\\."
      ]
    }
  }
}
```

**Customization:**
- Update `pathPatterns` to match your backend directory structure
- Add your specific frameworks to `keywords`
- Modify patterns in resource files to match your conventions

---

### frontend-dev-guidelines

**Tech Stack:** React, Material-UI v7, TypeScript

**Size:** Modular (SKILL.md + 8 resource files, follows 500-line rule)

**Coverage:**
- React component patterns
- MUI v7 integration
- State management (Context API, Zustand)
- Form handling with React Hook Form
- Routing with React Router
- API integration (React Query)
- Error boundaries
- Performance optimization
- Accessibility patterns
- Testing React components

**When to Use:**
- Building React applications
- Using Material-UI (MUI)
- TypeScript React development
- Modern React patterns (hooks, composition)

**Integration:**

```bash
# 1. Copy the skill
cp -r optional-components/skills/frontend-dev-guidelines/ .claude/skills/

# 2. Add to skill-rules.json
```

Add to [.claude/skills/skill-rules.json](../../.claude/skills/skill-rules.json):

```json
{
  "frontend-dev-guidelines": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "high",
    "description": "React/MUI v7 development patterns",
    "promptTriggers": {
      "keywords": [
        "frontend",
        "React",
        "component",
        "MUI",
        "Material-UI",
        "UI",
        "form",
        "state"
      ],
      "intentPatterns": [
        "(create|add|build).*?(component|page|form)",
        "(frontend|client|UI).*?(development|pattern)",
        "(add|implement).*?(state|hook|context)"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "frontend/**/*.tsx",
        "src/components/**/*.tsx",
        "src/pages/**/*.tsx",
        "src/hooks/**/*.ts"
      ],
      "contentPatterns": [
        "import.*from ['\"]react",
        "import.*from ['\"]@mui",
        "export.*function.*Component"
      ]
    }
  }
}
```

**Customization:**
- Update `pathPatterns` for your frontend structure
- Add your UI library to `keywords` if not using MUI
- Adapt patterns for your state management solution

---

### route-tester

**Tech Stack:** JWT cookie-based authentication, REST APIs

**Size:** Single file (SKILL.md)

**Coverage:**
- Testing authenticated API routes
- JWT cookie handling
- Route registration verification
- Request/response validation
- Error handling testing
- Authentication flow testing

**When to Use:**
- Building APIs with authentication
- Using JWT cookie-based auth
- Need to test protected routes
- Debugging authentication issues

**Integration:**

```bash
# 1. Copy the skill
cp -r optional-components/skills/route-tester/ .claude/skills/

# 2. Add to skill-rules.json
```

Add to [.claude/skills/skill-rules.json](../../.claude/skills/skill-rules.json):

```json
{
  "route-tester": {
    "type": "specialized",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "API route testing with JWT authentication",
    "promptTriggers": {
      "keywords": [
        "test route",
        "test endpoint",
        "test API",
        "authentication test",
        "route test"
      ],
      "intentPatterns": [
        "test.*?(route|endpoint|API)",
        "(test|verify).*?authentication"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "**/*.test.ts",
        "**/*.spec.ts",
        "tests/**/*.ts"
      ],
      "contentPatterns": [
        "describe.*route",
        "test.*endpoint"
      ]
    }
  }
}
```

**Customization:**
- Adapt auth patterns for your authentication method
- Update cookie handling for your session management
- Modify test patterns for your testing framework

---

### error-tracking

**Tech Stack:** Sentry error tracking

**Size:** Single file (SKILL.md)

**Coverage:**
- Sentry integration patterns
- Error capture best practices
- Context and breadcrumbs
- User feedback collection
- Performance monitoring
- Release tracking
- Source maps configuration

**When to Use:**
- Integrating Sentry for error tracking
- Setting up monitoring
- Debugging production issues
- Adding error context

**Integration:**

```bash
# 1. Copy the skill
cp -r optional-components/skills/error-tracking/ .claude/skills/

# 2. Add to skill-rules.json
```

Add to [.claude/skills/skill-rules.json](../../.claude/skills/skill-rules.json):

```json
{
  "error-tracking": {
    "type": "specialized",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "Sentry error tracking integration",
    "promptTriggers": {
      "keywords": [
        "Sentry",
        "error tracking",
        "error monitoring",
        "crash reporting"
      ],
      "intentPatterns": [
        "(add|integrate|setup).*?(Sentry|error tracking)",
        "(capture|track|log).*?error"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "**/*sentry*.ts",
        "**/*error*.ts"
      ],
      "contentPatterns": [
        "import.*@sentry",
        "Sentry\\."
      ]
    }
  }
}
```

**Customization:**
- Replace Sentry-specific patterns if using different service
- Add your error tracking conventions
- Update context patterns for your data structure

---

## From everything-claude-code

### backend-patterns

**Focus:** Universal backend patterns (framework-agnostic)

**Size:** Single file (SKILL.md)

**Coverage:**
- RESTful API design
- GraphQL patterns
- Caching strategies (Redis, in-memory)
- Message queues (Bull, RabbitMQ)
- Database optimization
- Rate limiting
- API versioning
- Webhook handling
- Background jobs
- Microservices patterns

**When to Use:**
- General backend architecture decisions
- Choosing caching strategies
- Implementing queuing systems
- API design patterns

**Difference from backend-dev-guidelines:**
- **backend-patterns**: Framework-agnostic, architectural patterns
- **backend-dev-guidelines**: Express/Prisma-specific implementation

**Integration:**

```bash
cp -r optional-components/skills/backend-patterns/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "backend-patterns": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "Universal backend architecture patterns",
    "promptTriggers": {
      "keywords": [
        "backend architecture",
        "API design",
        "caching",
        "queue",
        "microservices",
        "scalability"
      ],
      "intentPatterns": [
        "(design|architect).*?(API|backend|system)",
        "(add|implement).*?(cache|queue|worker)"
      ]
    }
  }
}
```

---

### frontend-patterns

**Focus:** Universal React patterns (UI library-agnostic)

**Size:** Single file (SKILL.md)

**Coverage:**
- Component composition patterns
- Custom hooks design
- State management strategies
- Performance optimization
- Code splitting
- Error boundaries
- Render props vs hooks
- Context API patterns
- Form patterns
- Data fetching patterns

**When to Use:**
- React architecture decisions
- Component design patterns
- Performance optimization
- State management choice

**Difference from frontend-dev-guidelines:**
- **frontend-patterns**: UI library-agnostic, architectural patterns
- **frontend-dev-guidelines**: MUI v7-specific implementation

**Integration:**

```bash
cp -r optional-components/skills/frontend-patterns/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "frontend-patterns": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "Universal React architecture patterns",
    "promptTriggers": {
      "keywords": [
        "React patterns",
        "component design",
        "hooks",
        "performance",
        "optimization"
      ],
      "intentPatterns": [
        "(design|architect).*?(component|React)",
        "(optimize|improve).*?(performance|rendering)"
      ]
    }
  }
}
```

---

### coding-standards

**Focus:** TypeScript code quality and organization

**Size:** Single file (SKILL.md)

**Coverage:**
- TypeScript best practices
- Naming conventions
- File organization
- Code structure principles (KISS, DRY, YAGNI)
- Error handling patterns
- Type safety
- Documentation standards
- Linting configuration

**When to Use:**
- Establishing team coding standards
- Code review criteria
- Refactoring guidance
- TypeScript migration

**Integration:**

```bash
cp -r optional-components/skills/coding-standards/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "coding-standards": {
    "type": "quality",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "TypeScript coding standards and best practices",
    "promptTriggers": {
      "keywords": [
        "code quality",
        "standards",
        "naming",
        "TypeScript",
        "best practices"
      ],
      "intentPatterns": [
        "(improve|refactor).*?(code|structure)",
        "(review|check).*?(quality|standards)"
      ]
    }
  }
}
```

---

### tdd-workflow

**Focus:** Test-driven development methodology

**Size:** Modular (SKILL.md + 3 resource files)

**Coverage:**
- RED → GREEN → REFACTOR cycle
- Writing effective tests
- Test structure (AAA pattern: Arrange, Act, Assert)
- Mocking and stubbing
- Test coverage analysis
- Integration vs unit tests
- E2E testing strategies
- Debugging test failures

**When to Use:**
- Implementing new features
- Bug fixes
- Refactoring code
- Team TDD adoption

**Integration:**

```bash
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "tdd-workflow": {
    "type": "methodology",
    "enforcement": "block",
    "priority": "critical",
    "description": "Test-driven development with 80% minimum coverage",
    "promptTriggers": {
      "keywords": [
        "TDD",
        "test driven",
        "write test",
        "test first",
        "test coverage"
      ],
      "intentPatterns": [
        "(implement|add|create).*?feature",
        "(fix|resolve).*?bug",
        "test.*?(first|driven)"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "**/*.test.ts",
        "**/*.spec.ts",
        "**/__tests__/**"
      ]
    }
  }
}
```

**Note:** `enforcement: "block"` makes TDD mandatory - Claude will require tests before implementation.

---

### security-review

**Focus:** Security vulnerability prevention and analysis

**Size:** Modular (SKILL.md + 2 resource files)

**Coverage:**
- OWASP Top 10 vulnerabilities
- Input validation patterns
- Authentication/authorization best practices
- Cryptography guidelines
- Dependency security
- API security
- XSS, CSRF, SQL injection prevention
- Security testing

**When to Use:**
- Before committing code
- Security audits
- Implementing authentication
- Handling sensitive data

**Integration:**

```bash
cp -r optional-components/skills/security-review/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "security-review": {
    "type": "quality",
    "enforcement": "warn",
    "priority": "high",
    "description": "Security vulnerability analysis and prevention",
    "promptTriggers": {
      "keywords": [
        "security",
        "vulnerability",
        "authentication",
        "authorization",
        "sensitive data"
      ],
      "intentPatterns": [
        "(security|vulnerability).*?(review|check|audit)",
        "(implement|add).*?(auth|security)"
      ]
    }
  }
}
```

---

### clickhouse-io

**Focus:** ClickHouse analytics database queries

**Size:** Single file (SKILL.md)

**Coverage:**
- ClickHouse query patterns
- Aggregation functions
- Time-series queries
- Performance optimization
- Data modeling for analytics
- Materialized views
- Query debugging

**When to Use:**
- Working with ClickHouse database
- Analytics queries
- Time-series data
- High-performance aggregations

**Integration:**

```bash
cp -r optional-components/skills/clickhouse-io/ .claude/skills/
```

Add to skill-rules.json:

```json
{
  "clickhouse-io": {
    "type": "specialized",
    "enforcement": "suggest",
    "priority": "medium",
    "description": "ClickHouse analytics database patterns",
    "promptTriggers": {
      "keywords": [
        "ClickHouse",
        "analytics",
        "aggregation",
        "time-series"
      ],
      "intentPatterns": [
        "(query|analyze).*?ClickHouse",
        "(analytics|metrics).*?database"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "**/*clickhouse*.ts",
        "**/*analytics*.ts"
      ]
    }
  }
}
```

---

### project-guidelines-example

**Focus:** Template for creating custom project-specific skills

**Size:** Single file (SKILL.md)

**Coverage:**
- How to structure a project skill
- What to include
- How to organize guidelines
- Examples of sections
- Integration with Claude Code

**When to Use:**
- Creating skills for your team
- Documenting project-specific patterns
- Custom framework guidelines
- Internal best practices

**Integration:**

```bash
# 1. Copy the example
cp optional-components/skills/project-guidelines-example/SKILL.md .claude/skills/my-project-guidelines/SKILL.md

# 2. Customize for your project
vim .claude/skills/my-project-guidelines/SKILL.md

# 3. Add to skill-rules.json with your triggers
```

---

## Choosing Skills for Your Project

### Full-Stack TypeScript Application

**Recommended:**
- backend-dev-guidelines (if using Node.js/Express/Prisma)
- frontend-dev-guidelines (if using React/MUI)
- error-tracking (for production monitoring)
- route-tester (for API testing)
- tdd-workflow (for test-driven development)

```bash
cp -r optional-components/skills/backend-dev-guidelines/ .claude/skills/
cp -r optional-components/skills/frontend-dev-guidelines/ .claude/skills/
cp -r optional-components/skills/error-tracking/ .claude/skills/
cp -r optional-components/skills/route-tester/ .claude/skills/
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

### Backend-Only API

**Recommended:**
- backend-dev-guidelines OR backend-patterns
- error-tracking
- route-tester
- tdd-workflow
- security-review

```bash
cp -r optional-components/skills/backend-dev-guidelines/ .claude/skills/
cp -r optional-components/skills/error-tracking/ .claude/skills/
cp -r optional-components/skills/route-tester/ .claude/skills/
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
cp -r optional-components/skills/security-review/ .claude/skills/
```

### Frontend-Only Application

**Recommended:**
- frontend-dev-guidelines OR frontend-patterns
- coding-standards
- tdd-workflow

```bash
cp -r optional-components/skills/frontend-dev-guidelines/ .claude/skills/
cp -r optional-components/skills/coding-standards/ .claude/skills/
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

### Analytics Platform

**Recommended:**
- clickhouse-io (if using ClickHouse)
- backend-patterns
- tdd-workflow

```bash
cp -r optional-components/skills/clickhouse-io/ .claude/skills/
cp -r optional-components/skills/backend-patterns/ .claude/skills/
cp -r optional-components/skills/tdd-workflow/ .claude/skills/
```

---

## Skill Combination Patterns

### When to Use Both Specific and General Skills

**Scenario:** React application with Material-UI

**Combine:**
- frontend-dev-guidelines (MUI-specific implementation)
- frontend-patterns (general React architecture)

**Why:** Guidelines provide specific MUI patterns, while patterns help with architectural decisions.

**Scenario:** Express API with custom patterns

**Combine:**
- backend-dev-guidelines (Express-specific)
- backend-patterns (architecture decisions)
- security-review (security validation)

**Why:** Guidelines for implementation, patterns for design, security for validation.

---

## Modular Skills (500-Line Rule)

Several skills use the modular pattern to avoid context limits:

```
skill-name/
  SKILL.md                  # <500 lines - Overview + navigation
  resources/
    topic-1.md              # <500 lines each
    topic-2.md
    topic-3.md
```

**How it works:**
1. Claude loads SKILL.md first (overview)
2. SKILL.md references specific resources
3. Claude loads resources only when explicitly needed
4. Keeps context manageable

**Example - backend-dev-guidelines:**
```
backend-dev-guidelines/
  SKILL.md                      # Overview + resource navigation
  resources/
    routing-patterns.md         # Express routing
    controllers.md              # Controller organization
    services.md                 # Service layer
    prisma-integration.md       # Database patterns
    authentication.md           # JWT auth
    error-handling.md           # Error middleware
    testing-backend.md          # Test patterns
    repository-pattern.md       # Data access
    dependency-injection.md     # DI patterns
    api-documentation.md        # OpenAPI/Swagger
    validation.md               # Zod validation
    background-jobs.md          # Worker patterns
```

**When to reference resources:**
```
User: "How do I structure controllers?"
Claude: Loads backend-dev-guidelines/resources/controllers.md

User: "Show me Prisma patterns"
Claude: Loads backend-dev-guidelines/resources/prisma-integration.md
```

---

## Customization

### Updating for Your Tech Stack

**Example: Using Fastify instead of Express**

1. Copy backend-dev-guidelines:
   ```bash
   cp -r optional-components/skills/backend-dev-guidelines/ .claude/skills/
   ```

2. Rename and update:
   ```bash
   mv .claude/skills/backend-dev-guidelines/ .claude/skills/backend-fastify/
   vim .claude/skills/backend-fastify/SKILL.md
   # Update routing patterns for Fastify
   # Update middleware patterns for Fastify plugins
   ```

3. Update skill-rules.json:
   ```json
   {
     "backend-fastify": {
       "keywords": ["Fastify", "backend", "API", "plugin"],
       "contentPatterns": ["fastify\\."]
     }
   }
   ```

### Creating Project-Specific Skills

Use project-guidelines-example as template:

```bash
# 1. Copy the template
cp optional-components/skills/project-guidelines-example/SKILL.md \
   .claude/skills/my-company-backend/SKILL.md

# 2. Customize sections:
#    - Your tech stack
#    - Your team conventions
#    - Your deployment patterns
#    - Your testing requirements

# 3. Add to skill-rules.json with company-specific keywords
```

---

## Integration with Other Components

### Skills + Agents

**Skills** provide guidelines and patterns
**Agents** execute specific tasks using those patterns

**Example:**
- **backend-dev-guidelines skill** teaches Express routing patterns
- **code-architecture-reviewer agent** reviews code against those patterns

### Skills + Rules

**Rules** establish mandatory practices
**Skills** provide implementation details

**Example:**
- **security.md rule** requires "All user inputs validated"
- **backend-dev-guidelines skill** shows Zod validation patterns

### Skills + Hooks

**Hooks** enforce automation
**Skills** guide what to automate

**Example:**
- **tdd-workflow skill** teaches write-tests-first
- **PostToolUse hook** runs tests after code changes

---

## Best Practices

### 1. Start Minimal, Add Incrementally

Don't copy all skills at once:
1. Start with 2-3 core skills for your stack
2. Add specialized skills as needs arise
3. Monitor skill activation patterns
4. Remove unused skills

### 2. Customize Path Patterns

Update `fileTriggers.pathPatterns` in skill-rules.json to match your structure:

```json
"pathPatterns": [
  "apps/api/**/*.ts",           // Monorepo
  "packages/backend/**/*.ts",   // Lerna/Yarn workspaces
  "src/server/**/*.ts"          // Single-app structure
]
```

### 3. Combine Complementary Skills

For comprehensive coverage:
- **Specific + General**: backend-dev-guidelines + backend-patterns
- **Implementation + Validation**: frontend-dev-guidelines + coding-standards
- **Development + Quality**: any skill + tdd-workflow

### 4. Keep Skills Updated

Skills should evolve with your project:
- Update when adopting new libraries
- Remove outdated patterns
- Add team-discovered best practices

---

## Troubleshooting

### Skill Not Activating

See [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md#troubleshooting) for detailed troubleshooting.

**Quick checks:**
1. Is skill copied to `.claude/skills/`?
2. Is skill configured in `skill-rules.json`?
3. Do keywords match your prompt?
4. Do path patterns match your files?

### Too Many Skills Activating

**Problem:** Multiple skills suggest for same task

**Solutions:**
1. **Adjust priority levels** in skill-rules.json:
   ```json
   "priority": "medium"  // Lower priority for less critical skills
   ```

2. **Make keywords more specific**:
   ```json
   "keywords": ["Express routing"]  // Instead of just "routing"
   ```

3. **Use file triggers** to limit activation context

### Context Limit Hit

**Problem:** Large skills consuming too much context

**Solutions:**
1. **Use modular pattern** - Break into resources
2. **Reference specific resources** - Don't load entire skill
3. **Keep SKILL.md under 500 lines**

---

## Learn More

- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Skill system:** [../../.claude/skills/README.md](../../.claude/skills/README.md)
- **skill-rules.json:** [../../.claude/skills/skill-rules.json](../../.claude/skills/skill-rules.json)
- **skill-developer:** [../../.claude/skills/skill-developer/](../../.claude/skills/skill-developer/)
- **Main guide:** [../../README.md](../../README.md)
