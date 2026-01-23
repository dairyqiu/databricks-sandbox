---
description: Review and suggest settings improvements based on usage patterns
---

# Settings Audit Command

Review current configuration and suggest improvements based on your usage.

## What This Command Does

1. Analyze current skill-rules.json
2. Check enforcement levels
3. Review coverage thresholds
4. Suggest improvements based on patterns
5. Recommend additional skills

## Execute

### Step 1: Read Current Configuration

Read and parse:
- `.claude/skills/skill-rules.json`
- `.claude/project-config.json` (if exists)
- `.claude/rules/*.md` (active rules)

### Step 2: Analyze Usage Patterns

Check recent git history for patterns:
```bash
# Files most frequently modified
git log --oneline --name-only -100 | grep -E '\.(ts|tsx|js|jsx)$' | sort | uniq -c | sort -rn | head -20

# Test file ratio
TESTS=$(git ls-files '*.test.ts' '*.spec.ts' | wc -l)
SOURCE=$(git ls-files '*.ts' | grep -v test | grep -v spec | wc -l)
RATIO=$((TESTS * 100 / SOURCE))
```

### Step 3: Check Enforcement Levels

Analyze current settings:

```
Enforcement Analysis
====================

Skill: tdd-workflow
├── Current: block
├── Status: ✅ Strong enforcement
└── Recommendation: Keep (best practice)

Skill: coding-standards
├── Current: suggest
├── Status: ⚠️ Could be stronger
└── Recommendation: Consider "warn" if code quality is priority

Skill: using-git-worktrees
├── Current: suggest
├── Status: ✓ Appropriate
└── Recommendation: Keep as suggest (optional workflow)
```

### Step 4: Review Coverage

If test coverage data available:
```bash
# Run coverage check
bun test --coverage --reporter=json 2>/dev/null
```

Parse results:
```
Coverage Analysis
=================

Current:    85%
Threshold:  80%
Status:     ✅ Above threshold

By Category:
├── Lines:      85%
├── Branches:   82%
├── Functions:  88%
└── Statements: 84%

Recommendation: Threshold appropriate
```

### Step 5: Detect Missing Skills

Based on project analysis:

```
Skill Recommendations
=====================

Based on your project structure and patterns:

1. Backend Development Skills
   ├── Detected: Express routes in src/api/
   ├── Detected: Database queries in src/services/
   └── Recommendation: Add backend-dev-guidelines skill

2. Frontend Development Skills
   ├── Detected: React components in src/components/
   ├── Detected: Hooks in src/hooks/
   └── Recommendation: Add frontend-dev-guidelines skill

3. API Documentation
   ├── Detected: REST endpoints
   ├── Missing: OpenAPI/Swagger spec
   └── Recommendation: Consider api-documentation skill

Commands to add skills:
  cp -r optional-components/skills/backend-dev-guidelines .claude/skills/
  cp -r optional-components/skills/frontend-dev-guidelines .claude/skills/
```

### Step 6: Generate Report

```
Settings Audit Report
=====================
Generated: 2024-01-15 10:30:00

Summary
-------
Active Skills: 5 (of 9 available in optional-components)
TDD Enforcement: block ✅
Coverage Threshold: 80% ✅
Current Coverage: 85% ✅

Enforcement Levels
------------------
✅ tdd-workflow: block (recommended)
✓  coding-standards: suggest
✓  skill-developer: suggest
✓  agent-developer: suggest
✓  using-git-worktrees: suggest

Recommendations
---------------

1. HIGH: Add backend-dev-guidelines
   You work in backend/ frequently. This skill provides
   Express patterns, database best practices, and API design.

   To add:
   cp -r optional-components/skills/backend-dev-guidelines .claude/skills/

2. MEDIUM: Add frontend-dev-guidelines
   React components detected. This skill provides
   component patterns, state management, and hooks best practices.

   To add:
   cp -r optional-components/skills/frontend-dev-guidelines .claude/skills/

3. LOW: Consider stricter coding-standards
   Current: suggest → Consider: warn
   This will show warnings for code quality issues without blocking.

Settings Evolution Guide
------------------------
Week 1-2: suggest (learning)
Week 3-4: warn (awareness)
Month 2+: block (enforcement) for critical skills

Your TDD compliance is 94% - great job!
Consider increasing coverage threshold to 85% as next goal.
```

### Step 7: Ask for Actions

Use AskUserQuestion:
```
header: "Actions"
question: "Which recommendations would you like to apply?"
multiSelect: true
options:
  - label: "Add backend-dev-guidelines"
    description: "Copy skill from optional-components"
  - label: "Add frontend-dev-guidelines"
    description: "Copy skill from optional-components"
  - label: "Change coding-standards to warn"
    description: "Increase enforcement level"
  - label: "None"
    description: "Keep current settings"
```

### Step 8: Apply Selected Changes

For each selected action:
1. Copy skills if needed
2. Update skill-rules.json
3. Report changes made

## Output Modes

```
/settings-audit              # Full report with recommendations
/settings-audit --brief      # Summary only
/settings-audit --json       # JSON output for scripting
/settings-audit --apply      # Auto-apply all recommendations
```

## Related Commands

- `/init-project` - Initial project setup
- `/update-template` - Update template version
- `/tdd-check` - Check TDD compliance
