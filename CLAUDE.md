# Claude Code Multi-Project Starter Template

## Quick Start
This is the base template for Claude Code projects with universal skills, agents, and rules.

## Available Commands
| Command | Purpose |
|---------|---------|
| `/dev-docs [task]` | Convert approved plan to persistent task tracking |
| `/dev-docs-update` | Update task progress before context reset |
| `/code-review` | Review recent code changes |
| `/tdd [feature]` | Test-driven development workflow |
| `/build-fix` | Fix build/compilation errors |
| `/create-skill [name]` | Interactive wizard to scaffold a new skill |
| `/create-agent [name]` | Interactive wizard to scaffold a new agent |

## Planning Workflow
For complex features, Claude proactively uses built-in plan mode:
1. **Plan** - Claude enters plan mode → Creates plan in `~/.claude/plans/` → You approve
2. **Persist** - `/dev-docs [feature]` → Converts plan to tracking structure in `dev/active/`
3. **Implement** - `/tdd` → Build with tests (update context with `/dev-docs-update`)
4. **Document** - `documentation-architect` agent → Create reference docs

## Active Rules (Always Enforced)
- **Security**: No hardcoded secrets, validate all inputs ([.claude/rules/security.md](.claude/rules/security.md))
- **Git**: Use conventional commits ([.claude/rules/git-workflow.md](.claude/rules/git-workflow.md))
- **Code**: Immutable patterns, files <800 lines ([.claude/rules/coding-style.md](.claude/rules/coding-style.md))
- **Testing**: 80% minimum coverage ([.claude/rules/testing.md](.claude/rules/testing.md))

## Skills (Auto-Activate)
Skills suggest themselves based on context:
- Mention "skill" → skill-developer activates
- Mention "quality/refactor/standards" → coding-standards activates
- Mention "test/TDD" → tdd-workflow activates

## Agents (Auto-Invoke)
Claude delegates to specialized agents:
- Complex features → Built-in plan mode (EnterPlanMode)
- After writing code → code-reviewer agent
- Security concerns → security-reviewer agent
- Build failures → build-error-resolver agent

## Project Structure
```
.claude/
├── skills/          # Domain knowledge (auto-activates)
├── rules/           # Behavioral guidelines (always active)
├── agents/          # Specialized task handlers (auto-invoked)
├── commands/        # Slash commands (/dev-docs, /tdd, etc.)
└── hooks/           # Automation scripts (skill activation, tracking)
```

## Customization
See [TEMPLATE_SETUP_GUIDE.md](TEMPLATE_SETUP_GUIDE.md) for:
- Adding domain-specific skills from optional-components/
- Customizing rules for your team
- Configuring hooks and automation
- Model selection strategy (Haiku/Sonnet/Opus)

## For Claude
When working in this project:
1. Follow all rules in `.claude/rules/` (always active)
2. Let skills auto-activate based on context (don't force)
3. Invoke agents proactively for complex tasks
4. Use commands for common workflows
5. Respect 500-line skill limit (universal standards only)
