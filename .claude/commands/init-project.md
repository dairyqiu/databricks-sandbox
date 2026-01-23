---
description: Interactive wizard for new project setup. Detects project type and configures skills.
---

# Init Project Command

Interactive wizard to configure the Claude Code template for a specific project.

## What This Command Does

1. **Detect Project Type** - Analyze files to determine language/framework
2. **Ask Configuration Questions** - Use AskUserQuestion for preferences
3. **Configure Skills** - Copy relevant optional skills
4. **Update Settings** - Modify skill-rules.json with project paths
5. **Create Config File** - Save project-config.json for persistence

## Execute

### Step 1: Detect Project Type

Scan the project root for indicator files:

```
package.json     → JavaScript/TypeScript project
tsconfig.json    → TypeScript
pyproject.toml   → Python (uv)
requirements.txt → Python
Cargo.toml       → Rust
go.mod           → Go
```

Check package.json for frameworks:
- `next` → Next.js
- `react` → React
- `express` → Express backend
- `vite` → Vite frontend
- `vitest` / `jest` → Testing framework

### Step 2: Ask Configuration Questions

Use **AskUserQuestion** tool with these questions:

**Question 1: Project Type**
```
header: "Type"
question: "What type of project is this?"
options:
  - label: "Fullstack (Frontend + Backend)"
    description: "Combined frontend and backend in one repo"
  - label: "Backend API"
    description: "Server-side API or services"
  - label: "Frontend SPA"
    description: "Single page application (React, Vue, etc.)"
  - label: "CLI Tool"
    description: "Command-line application"
```

**Question 2: Testing Framework**
```
header: "Testing"
question: "Which testing framework should be used?"
options:
  - label: "Vitest (Recommended)"
    description: "Fast, Vite-native testing"
  - label: "Jest"
    description: "Mature, widely-used"
  - label: "Playwright"
    description: "E2E browser testing"
  - label: "None yet"
    description: "I'll set up testing later"
```

**Question 3: TDD Enforcement**
```
header: "TDD"
question: "How strictly should TDD be enforced?"
options:
  - label: "Block (Recommended)"
    description: "Block edits to source files without tests"
  - label: "Suggest"
    description: "Suggest TDD but allow proceeding"
  - label: "Off"
    description: "No TDD enforcement"
```

**Question 4: Optional Skills**
```
header: "Skills"
question: "Which optional skills should be added?"
multiSelect: true
options:
  - label: "Backend Guidelines"
    description: "Express, API patterns, database access"
  - label: "Frontend Guidelines"
    description: "React, state management, components"
  - label: "None"
    description: "Start with base skills only"
```

### Step 3: Apply Configuration

Based on answers:

1. **Copy Optional Skills** (if selected):
   ```bash
   cp -r .claude/optional-components/skills/backend-dev-guidelines .claude/skills/
   cp -r .claude/optional-components/skills/frontend-dev-guidelines .claude/skills/
   ```

2. **Update skill-rules.json**:
   - Set `tdd-workflow.enforcement` based on TDD answer
   - Add path patterns for project structure

3. **Create project-config.json**:
   ```json
   {
     "projectType": "<selected>",
     "testFramework": "<selected>",
     "packageManager": "bun",
     "tddEnforcement": "<selected>",
     "paths": {
       "source": "src/",
       "tests": "**/*.test.ts"
     },
     "customSkills": ["<selected>"],
     "templateVersion": "1.0.0",
     "initialized": "<timestamp>"
   }
   ```

### Step 4: Report Configuration

Output summary:
```
✅ Project Configuration Complete

Project Type: Fullstack
Test Framework: Vitest
TDD Enforcement: Block
Skills Added: backend-dev-guidelines, frontend-dev-guidelines

Files Modified:
- .claude/skills/skill-rules.json
- .claude/project-config.json

Next Steps:
1. Run `/feature <name>` to start your first feature
2. Use `/tdd` for test-driven development
3. Check /tdd-check to verify compliance
```

## Idempotent Behavior

If `.claude/project-config.json` already exists:
- Show current configuration
- Ask: "Project already configured. Reconfigure? [Yes/No]"
- If No, exit with current config summary
- If Yes, proceed with wizard (preserves customSkills)

## Error Handling

- If optional-components/ missing: Skip skill copying, warn user
- If skill-rules.json invalid: Backup and recreate
- If no write permissions: Error with instructions
