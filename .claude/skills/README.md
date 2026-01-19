# Universal Skills

Three skills that apply to ALL project types - AI research, web apps, Mac apps, data science, etc.

---

## What's Included

This directory contains **3 universal skills**:

1. **skill-developer/** - Meta-skill for creating and managing skills
2. **coding-standards/** - TypeScript coding standards and best practices
3. **tdd-workflow/** - Test-driven development methodology

These skills provide universal quality practices that work regardless of tech stack. Domain-specific skills (backend-dev-guidelines, frontend-dev-guidelines) remain in optional-components.

---

## skill-developer

**Purpose:** Helps you create, modify, and understand the skill system itself.

**When it activates:** When you mention "skill", "create skill", "skill triggers", etc.

**What it provides:**
- Skill system architecture
- How to create new skills
- skill-rules.json configuration
- Hook integration patterns
- Progressive disclosure (500-line rule)
- Troubleshooting guide

**Use it for:**
- Creating custom skills for your project
- Understanding how auto-activation works
- Debugging skill trigger issues
- Learning the modular skill pattern

---

## coding-standards

**Purpose:** Provides TypeScript coding standards and best practices.

**When it activates:** When you mention "code quality", "standards", "refactor", "clean code", etc.

**What it provides:**
- TypeScript best practices
- Naming conventions
- File organization principles
- Code structure guidelines
- SOLID principles
- DRY, KISS, YAGNI patterns

**Use it for:**
- Maintaining code quality
- Refactoring existing code
- Establishing team standards
- Code review guidelines

**Size:** Single file (~300 lines)

---

## tdd-workflow

**Purpose:** Enforces test-driven development methodology with 80% minimum coverage.

**When it activates:** When you mention "TDD", "test first", "testing", or work with test files.

**What it provides:**
- RED → GREEN → REFACTOR cycle
- Test structure (AAA pattern: Arrange, Act, Assert)
- Writing effective tests
- Mocking and stubbing strategies
- Test coverage analysis
- Integration vs unit tests
- E2E testing strategies
- Debugging test failures

**Use it for:**
- Implementing new features test-first
- Fixing bugs with regression tests
- Ensuring adequate test coverage
- Learning TDD methodology

**Size:** Modular (SKILL.md + 3 resource files)

**File Triggers:** Automatically activates when editing:
- `**/*.test.ts`
- `**/*.spec.ts`
- `**/__tests__/**`
- `**/tests/**`

---

## skill-rules.json

This file controls **which skills auto-activate** and **when**. The base configuration includes 3 universal skills:

```json
{
  "skills": {
    "skill-developer": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["skill system", "create skill", "add skill"],
        "intentPatterns": ["(create|add|modify).*?skill"]
      }
    },
    "coding-standards": {
      "type": "quality",
      "enforcement": "suggest",
      "priority": "medium",
      "promptTriggers": {
        "keywords": ["code quality", "standards", "refactor", "clean code"],
        "intentPatterns": ["(improve|refactor).*?(code|structure)"]
      }
    },
    "tdd-workflow": {
      "type": "methodology",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["TDD", "test driven", "test first", "testing"],
        "intentPatterns": ["(implement|add|create).*?feature"]
      },
      "fileTriggers": {
        "pathPatterns": ["**/*.test.ts", "**/*.spec.ts", "**/__tests__/**"]
      }
    }
  }
}
```

### Adding Skills

When you copy skills from [optional-components/skills/](../../optional-components/skills/), add their trigger configurations here.

**Example - Adding backend-dev-guidelines:**

```json
{
  "skills": {
    "skill-developer": { ... },
    "backend-dev-guidelines": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["backend", "API", "route", "controller", "service"],
        "intentPatterns": ["(create|add).*?(route|endpoint|API)"]
      },
      "fileTriggers": {
        "pathPatterns": ["backend/**/*.ts", "api/**/*.ts"],
        "contentPatterns": ["router\\.", "export.*Controller"]
      }
    }
  }
}
```

See [optional-components/skills/README.md](../../optional-components/skills/README.md) for pre-made configurations.

---

## Optional Domain-Specific Skills

Browse [optional-components/skills/](../../optional-components/skills/) for **9 domain-specific skills**:

### Backend Development
- **backend-dev-guidelines** - Node.js/Express/Prisma patterns
- **backend-patterns** - API design, caching, queuing, microservices
- **route-tester** - JWT cookie authentication testing

### Frontend Development
- **frontend-dev-guidelines** - React/MUI v7 patterns
- **frontend-patterns** - React composition, custom hooks, performance

### Security
- **security-review** - Security checklist and OWASP Top 10

### Databases
- **clickhouse-io** - ClickHouse analytics queries
- **error-tracking** - Sentry integration patterns

**Note:** The 2 most universal skills (coding-standards, tdd-workflow) have been moved to the base template above.

---

## How Skills Work

### Trigger System

Skills auto-activate based on three trigger types:

1. **Keyword Triggers** - Match specific words in your prompt
   ```json
   "keywords": ["backend", "API", "route"]
   ```

2. **Intent Pattern Triggers** - Match regex patterns for user intent
   ```json
   "intentPatterns": ["(create|add).*?(route|API)"]
   ```

3. **File Triggers** - Match file paths or content patterns
   ```json
   "fileTriggers": {
     "pathPatterns": ["backend/**/*.ts"],
     "contentPatterns": ["router\\."]
   }
   ```

### Enforcement Levels

- **suggest** - Skill appears as suggestion (non-blocking)
- **block** - Requires skill use before proceeding (guardrail)
- **warn** - Shows warning but allows proceeding

### Priority Levels

- **critical** - Always trigger when matched
- **high** - Trigger for most matches
- **medium** - Trigger for clear matches
- **low** - Trigger only for explicit matches

---

## Modular Skill Pattern (500-Line Rule)

Skills larger than 500 lines use the modular pattern:

```
skill-name/
  SKILL.md                  # <500 lines - Overview + navigation
  resources/
    topic-1.md              # <500 lines each
    topic-2.md
    topic-3.md
```

**Why?**
- Large skills hit context limits
- Progressive disclosure keeps context manageable
- Claude loads main file, then resources only when needed

**Example:** backend-dev-guidelines has 12 resource files covering routing, controllers, services, testing, etc.

---

## Integration Workflow

### 1. Choose a Skill

Browse [optional-components/skills/](../../optional-components/skills/) and pick what you need.

### 2. Copy the Skill

```bash
cp -r optional-components/skills/backend-dev-guidelines/ .claude/skills/
```

### 3. Add to skill-rules.json

Copy the trigger configuration from [optional-components/skills/README.md](../../optional-components/skills/README.md) and add to [skill-rules.json](skill-rules.json).

### 4. Test It

- Type a trigger keyword (e.g., "backend") - skill should suggest
- Edit a matching file (e.g., `api/routes/users.ts`) - skill should activate
- Use the skill to verify it loads correctly

---

## Customization

### Update Path Patterns

Match your project structure:

```json
"fileTriggers": {
  "pathPatterns": [
    "src/api/**/*.ts",        // Your actual paths
    "server/routes/**/*.ts"
  ]
}
```

### Add Domain Keywords

Include your specific terminology:

```json
"keywords": [
  "backend",
  "API",
  "YourFramework",          // Your framework
  "YourDatabase"            // Your database
]
```

### Adjust Intent Patterns

Match how your team talks:

```json
"intentPatterns": [
  "(build|create|make).*?(endpoint|route)",
  "add.*?(API|service)"
]
```

---

## Troubleshooting

### Skill not auto-suggesting

1. **Check skill-rules.json** - Is skill configured with triggers?
2. **Verify keywords** - Does your prompt include trigger keywords?
3. **Test manually** - Use Skill tool directly to verify skill works
4. **Check hook** - Is skill-activation-prompt hook running?

### Skill loads but doesn't help

1. **Review SKILL.md** - Does it cover your use case?
2. **Check resources** - Try loading specific resource files
3. **Update skill** - May need customization for your tech stack

### Context limits hit

1. **Use modular pattern** - Break large skills into resources
2. **Reference selectively** - Load only needed resource files
3. **Keep SKILL.md under 500 lines** - Overview only

---

## File Structure

```
skills/
├── skill-developer/        # Meta-skill (universal)
│   ├── SKILL.md           # Main skill file
│   └── resources/         # 7 resource files
├── skill-rules.json       # Trigger configuration
└── README.md              # This file
```

---

## Learn More

- **Optional skills:** [../../optional-components/skills/README.md](../../optional-components/skills/README.md)
- **Hooks:** [../hooks/README.md](../hooks/README.md)
- **Main guide:** [../../README.md](../../README.md)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
