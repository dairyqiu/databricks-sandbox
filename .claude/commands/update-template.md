---
description: Pull latest template updates into existing project while preserving customizations
---

# Update Template Command

Pull the latest Claude Code template updates while preserving your customizations.

## What This Command Does

1. Check current template version
2. Show what would change
3. Preserve project customizations
4. Merge new skills/agents/rules
5. Update configurations safely

## Prerequisites

Set template source in `.claude/project-config.json`:
```json
{
  "templateVersion": "1.0.0",
  "templateSource": "https://github.com/your-org/claude-code-template"
}
```

## Execute

### Step 1: Check Current Version

Read `.claude/project-config.json` for current version:
```bash
cat .claude/project-config.json | jq -r '.templateVersion'
```

### Step 2: Fetch Latest Version

Check template source for latest:
```bash
# If git-based
git ls-remote --tags <template-source> | tail -1

# Or check release API
curl -s https://api.github.com/repos/<org>/<repo>/releases/latest
```

### Step 3: Show Diff Preview

Compare current vs latest:

```
Template Update Preview
=======================

Current Version: 1.0.0
Latest Version:  1.2.0

Changes:
├── NEW: .claude/commands/init-project.md
├── NEW: .claude/commands/tdd-check.md
├── UPDATED: .claude/skills/skill-rules.json
│   - Added: tdd-workflow.enforcement = "block"
│   - Added: new keywords for triggers
├── UPDATED: .claude/agents/tdd-guide.md
│   - Integration-First methodology
├── UNCHANGED: .claude/rules/* (your rules preserved)
└── UNCHANGED: .claude/project-config.json (your settings preserved)

Files that will NOT be touched:
- .claude/project-config.json (project settings)
- .claude/skills/custom-* (custom skills)
- .claude/agents/custom-* (custom agents)
- Any file in .claude/local/ (if exists)
```

### Step 4: Confirm Update

Use AskUserQuestion:
```
header: "Update"
question: "Apply template updates?"
options:
  - label: "Yes, update"
    description: "Apply changes shown above"
  - label: "Preview only"
    description: "Don't make changes, just show what would happen"
  - label: "Cancel"
    description: "Keep current version"
```

### Step 5: Apply Updates

For each updated file:

1. **New files:** Copy directly
2. **Updated base files:** Replace (they're not customized)
3. **Merged files (skill-rules.json):**
   - Keep project-specific skills
   - Add new base skills
   - Update changed base skills

### Step 6: Update Version

Update `.claude/project-config.json`:
```json
{
  "templateVersion": "1.2.0",
  "lastUpdated": "2024-01-15T10:30:00Z"
}
```

### Step 7: Report

```
Template Update Complete
========================

Updated to: 1.2.0

New Files: 2
- .claude/commands/init-project.md
- .claude/commands/tdd-check.md

Updated Files: 2
- .claude/skills/skill-rules.json
- .claude/agents/tdd-guide.md

Preserved:
- Your custom skills
- Your project configuration
- Your local overrides

Next Steps:
1. Review changes in updated files
2. Test that your workflows still work
3. Check /tdd-check for compliance
```

## Preservation Rules

**Always preserved (never overwritten):**
- `.claude/project-config.json`
- `.claude/local/*` (local overrides directory)
- Files starting with `custom-`
- Files in `.claude/skills/` that aren't in base template

**Merged (custom + updates):**
- `.claude/skills/skill-rules.json` (your skills + base skills)

**Replaced (base template files):**
- `.claude/commands/*.md` (base commands)
- `.claude/agents/*.md` (base agents)
- `.claude/rules/*.md` (base rules)
- `.claude/hooks/*.sh` (base hooks)

## Rollback

If update causes issues:

```bash
# Restore from git
git checkout HEAD~1 -- .claude/

# Or manually restore specific file
git show HEAD~1:.claude/agents/tdd-guide.md > .claude/agents/tdd-guide.md
```

## Manual Update

If automated update fails, manually:

1. Download latest template
2. Copy new/updated files manually
3. Update version in project-config.json

## Error Handling

- **No project-config.json:** Create one first with `/init-project`
- **No template source:** Ask user for template source URL
- **Merge conflicts:** Show conflict and ask user to resolve
- **Network error:** Retry or skip with warning
