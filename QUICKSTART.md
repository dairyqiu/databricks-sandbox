# Quick Start (5 Minutes)

Copy this template to any project and start using Claude Code enhanced workflows.

## 1. Copy to New Project

```bash
cp -r .claude/ /path/to/your-project/
cp CLAUDE.md /path/to/your-project/
```

## 2. Install Dependencies (if using hooks)

```bash
cd .claude/hooks && bun install
```

## 3. Initialize Project Config (Optional)

```bash
# Interactive wizard for project-specific settings
/init-project
```

## 4. Verify Setup

Type any of these to verify skills activate:
- `"skill"` → skill-developer suggestion
- `"TDD"` → tdd-workflow suggestion
- `"test"` → tdd-workflow suggestion

## 5. Start Working

```
/feature my-first-feature    # Start with planning + tracking
/tdd                         # Test-driven development
/ralph-dev "task"            # Autonomous mode
```

---

## Quick Reference

### Core Commands
| Command | Purpose |
|---------|---------|
| `/feature [name]` | Start feature with plan + tracking |
| `/tdd` | Test-driven development |
| `/dev-docs-update` | Sync progress before context reset |
| `/build-fix` | Fix build errors |

### Workflow
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  /feature   │───▶│  Plan Mode  │───▶│  /dev-docs  │
└─────────────┘    └─────────────┘    └─────────────┘
                                             │
                   ┌─────────────────────────┴─────────────────────────┐
                   ▼                                                   ▼
          ┌─────────────┐                                     ┌─────────────┐
          │   Manual    │                                     │   --ralph   │
          │   Workflow  │                                     │  Autonomous │
          └─────────────┘                                     └─────────────┘
```

### TDD Workflow (Integration-First)
```
┌───────────────────┐    ┌───────────────┐    ┌────────────────┐
│ 1. Integration    │───▶│ 2. Unit Tests │───▶│ 3. Implement   │
│    Skeleton       │    │    for Logic  │    │    & Wire Up   │
└───────────────────┘    └───────────────┘    └────────────────┘
     (Walking Skeleton)       (Complex Parts)      (GREEN)
```

---

## Customization

See [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md) for:
- Adding domain-specific skills
- Configuring TDD enforcement level
- Setting up hooks
- Model selection (Haiku/Sonnet/Opus)

---

## Troubleshooting

**Skills not suggesting?**
- Check `.claude/skills/skill-rules.json` exists
- Verify keywords match your prompts

**TDD not blocking edits?**
- Set `enforcement: "block"` in skill-rules.json
- Enable tdd-enforcement.sh hook

**Need help?**
- `/help` for available commands
- Check `.claude/rules/` for active guidelines
