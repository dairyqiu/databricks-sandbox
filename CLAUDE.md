# Claude Code Template

## Commands
| Command | Purpose |
|---------|---------|
| `/feature [name]` | Start feature with plan + tracking |
| `/init-project` | Interactive project setup wizard |
| `/tdd` | Test-driven development (integration-first) |
| `/tdd-check` | Verify TDD compliance |
| `/dev-docs [task]` | Convert plan to persistent tracking |
| `/dev-docs-update` | Sync progress before context reset |
| `/build-fix` | Fix build/compilation errors |
| `/code-review` | Review recent changes |
| `/ralph-dev "task"` | Autonomous development loop |
| `/create-skill` | Create new skill |
| `/create-agent` | Create new agent |

## Workflow
```
/feature → Plan → Approve → /dev-docs → Implement (manual or --ralph)
```

## Active Rules (Always Enforced)
- **Security**: No secrets, validate inputs ([rules/security.md](.claude/rules/security.md))
- **Git**: Conventional commits ([rules/git-workflow.md](.claude/rules/git-workflow.md))
- **Code**: Immutable, <800 lines ([rules/coding-style.md](.claude/rules/coding-style.md))
- **Testing**: 80% coverage, TDD ([rules/testing.md](.claude/rules/testing.md))

## Auto-Behaviors
- Skills activate on keywords (TDD, skill, test, etc.)
- Agents invoke for complex tasks (code-reviewer, security-reviewer)
- TDD blocks edits without tests (when enforcement=block)

## Project Structure
```
.claude/
├── skills/      # Auto-activating domain knowledge
├── rules/       # Always-active guidelines
├── agents/      # Specialized task handlers
├── commands/    # Slash commands
└── hooks/       # Automation scripts
```

## For Claude
1. Follow `.claude/rules/` (always active)
2. Let skills auto-activate (don't force)
3. Invoke agents proactively
4. Use TDD (integration-first)

See [QUICKSTART.md](QUICKSTART.md) | [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md)
