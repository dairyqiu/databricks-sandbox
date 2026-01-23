# Ralph Wiggum Plugin

Self-referential autonomous loop plugin with dev-docs integration and comprehensive loop prevention safeguards.

## Overview

The Ralph Wiggum plugin implements an autonomous coding loop where Claude continues working on a task across multiple turns without requiring user input between iterations. It's based on the [Ralph Technique](https://ghuntley.com/ralph/) and includes extensive safety mechanisms.

## Features

- **Self-referential loop**: Automatically continues work until task completion
- **Dev-docs integration**: Persists context for crash recovery
- **Safety safeguards**: Max iterations, runtime limits, stuck detection, quality gates
- **Per-iteration sync**: Context saved every iteration for maximum recoverability

## Commands

| Command | Description |
|---------|-------------|
| `/ralph-loop "<task>"` | Start basic autonomous loop |
| `/ralph-dev "<task>"` | Start loop with full dev-docs persistence |
| `/ralph-status` | Show current loop status and metrics |
| `/ralph-resume` | Resume paused or crashed loop |
| `/cancel-ralph` | Stop the current loop |

## Usage

### Basic Loop

```
/ralph-loop "Create a REST API for user management" --max-iterations 30
```

### With Dev-Docs Integration (Recommended)

```
/ralph-dev "Build todo API with tests"
```

This automatically:
- Creates `dev/active/ralph-todo-api/` structure
- Syncs context every iteration
- Enables quality gates
- Saves checkpoints for recovery

### Command Options

| Option | Default | Description |
|--------|---------|-------------|
| `--max-iterations N` | 50 | Maximum loop iterations |
| `--timeout N` | 240 | Max runtime in minutes |
| `--quality-gates` | enabled | Run tests/lint each iteration |
| `--completion-promise "text"` | "COMPLETE" | Text to signal completion |

## Safety Mechanisms

All safeguards are enabled by default:

1. **Max Iterations**: Hard limit (default: 50)
2. **Runtime Limit**: Maximum execution time (default: 4 hours)
3. **Idle Timeout**: Exit if no file changes for 5 iterations
4. **Stuck Detection**: Exit after 3 identical failures
5. **Quality Gates**: Run tests/lint before continuing
6. **Context Sync**: Persist state every iteration

## Completion

The loop exits when Claude outputs:

```
<promise>COMPLETE</promise>
```

Or when any safety limit is reached.

## Recovery

If Claude crashes or context resets:

```
/ralph-resume
```

This restores from the latest checkpoint in `dev/active/ralph-<task>/checkpoints/`.

## Directory Structure

```
.claude/plugins/ralph-wiggum/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/
│   ├── ralph-loop.md        # Start loop
│   └── cancel-ralph.md      # Cancel loop
├── hooks/
│   └── stop-hook.sh         # Core loop logic
├── scripts/
│   └── ralph-utils.sh       # Utility functions
└── README.md                # This file

.claude/hooks/
├── ralph-iteration-guard.sh  # Max iteration enforcement
├── ralph-stuck-detector.sh   # Stuck detection
├── ralph-quality-gate.sh     # Quality gates
└── ralph-context-sync.sh     # Dev-docs sync

.claude/commands/
├── ralph-dev.md              # Integrated loop + dev-docs
├── ralph-status.md           # Status reporting
└── ralph-resume.md           # Resume from crash
```

## State File

Ralph state is stored in `.claude/ralph-state.json`:

```json
{
  "active": true,
  "taskDescription": "Build todo API",
  "startTime": "2024-01-20T10:30:00Z",
  "iteration": 5,
  "maxIterations": 50,
  "completionPromise": "COMPLETE",
  "persistContext": true,
  "qualityGates": true,
  "timeoutMinutes": 240,
  "taskDir": "dev/active/ralph-build-todo-api",
  "lastError": null,
  "errorCount": {},
  "filesModified": ["src/api.ts", "src/tests/api.test.ts"],
  "lastFileChangeIteration": 5,
  "testsStatus": "pass"
}
```

## Best Practices

1. **Use `/ralph-dev`** for important tasks - the persistence is worth it
2. **Set realistic iteration limits** - 30-50 for medium tasks
3. **Enable quality gates** for production code
4. **Check `/ralph-status`** periodically for long-running tasks
5. **Use `/ralph-resume`** after any interruption

## Troubleshooting

### Loop not starting

Check that `.claude/settings.json` includes the Stop hook:

```json
"Stop": [
  {
    "hooks": [
      {
        "type": "command",
        "command": "$CLAUDE_PROJECT_DIR/.claude/plugins/ralph-wiggum/hooks/stop-hook.sh"
      }
    ]
  }
]
```

### Loop stuck

Run `/ralph-status --verbose` to see error history. Use `/ralph-resume --reset-errors` to clear error counts and try again.

### Context not persisting

Ensure `--persist-context` is enabled (automatic with `/ralph-dev`).

## References

- [Ralph Technique](https://ghuntley.com/ralph/)
- [Ralph Orchestrator](https://github.com/mikeyobrien/ralph-orchestrator)
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks-guide)
