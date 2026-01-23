# Hooks System

Hooks that power skill auto-activation, file tracking, Ralph autonomous loop, and enforcement rules.

---

## Quick Fix: UserPromptSubmit Error

If you're seeing `UserPromptSubmit` hook errors, install dependencies:

```bash
cd .claude/hooks && bun install
```

The `skill-activation-prompt.sh` requires `tsx` to run TypeScript.

---

## Current Active Hooks

Hooks are configured in two locations:
- **Project-level:** `.claude/settings.json` (this repo)
- **User-level:** `~/.claude/settings.json` (global)

### Project Hooks (`.claude/settings.json`)

#### UserPromptSubmit

| Hook | Purpose |
|------|---------|
| `skill-activation-prompt.sh` | Auto-suggests skills based on prompt keywords and file context |

**How it works:**
1. Reads [skill-rules.json](../skills/skill-rules.json)
2. Matches prompt against trigger keywords/patterns
3. Injects skill suggestions into Claude's context

#### PostToolUse

| Hook | Matcher | Purpose |
|------|---------|---------|
| `post-tool-use-tracker.sh` | `Edit\|MultiEdit\|Write` | Tracks file changes for smarter skill suggestions |

#### Stop

| Hook | Purpose |
|------|---------|
| `ralph-wiggum/hooks/stop-hook.sh` | Core loop continuation logic for Ralph autonomous loop |

---

### User Hooks (`~/.claude/settings.json`)

#### PreToolUse - Package Manager Enforcement

| Hook | Matcher | Purpose |
|------|---------|---------|
| pip/poetry blocker | `Bash` | Blocks `pip install`, `pip3 install`, `poetry add` → suggests `uv` |
| npm/yarn/pnpm blocker | `Bash` | Blocks `npm install`, `yarn install`, `pnpm install` → suggests `bun` |

**Exit codes:**
- `exit 0` - Allow silently
- `exit 1` - Allow with warning message
- `exit 2` - Block the command

---

## Ralph Safety Hooks

Located in `.claude/hooks/` but configured via Ralph plugin:

| Hook | Type | Purpose |
|------|------|---------|
| `ralph-iteration-guard.sh` | PreToolUse | Enforces max iterations (50) and runtime limits (4hr) |
| `ralph-stuck-detector.sh` | PostToolUse | Detects repeated errors (3+ identical failures) → pauses loop |
| `ralph-quality-gate.sh` | PostToolUse | Runs tests/lint after file modifications |
| `ralph-context-sync.sh` | PostToolUse | Persists context to `dev/active/` for crash recovery |

---

## Hook Types Reference

### UserPromptSubmit

```
User types prompt → Hook runs → Can modify prompt → Claude sees result
```

**Use cases:** Inject context, suggest skills, enforce guardrails

### PreToolUse

```
Claude wants to use tool → Hook runs → Can block/modify → Tool executes
```

**Use cases:** Block dangerous operations, enforce package managers, require confirmations

**Exit codes:**
- `0` - Allow (no output shown)
- `1` - Allow with warning (stdout shown as warning)
- `2` - Block (stdout shown as error)

### PostToolUse

```
Tool completes → Hook runs → Can update state/run validators
```

**Use cases:** Track changes, run linters, format code, quality gates

### Stop

```
Session ends → Hook runs → Cleanup/verification
```

**Use cases:** Final validations, check for debug code, Ralph loop continuation

---

## Adding New Hooks

### Block a Command (PreToolUse)

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "if echo \"$CLAUDE_TOOL_INPUT\" | grep -qE 'pattern'; then echo 'BLOCK: Message'; exit 2; fi"
          }
        ]
      }
    ]
  }
}
```

### Run Validator After Edit (PostToolUse)

Add to `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "your-validator-script.sh"
          }
        ]
      }
    ]
  }
}
```

### Environment Variables Available

| Variable | Description |
|----------|-------------|
| `CLAUDE_PROJECT_DIR` | Project root directory |
| `CLAUDE_TOOL_INPUT` | JSON input to the tool |
| `CLAUDE_TOOL_OUTPUT` | JSON output from tool (PostToolUse only) |

---

## File Structure

```
hooks/
├── skill-activation-prompt.sh    # Shell wrapper (runs .ts via tsx)
├── skill-activation-prompt.ts    # Skill activation logic
├── post-tool-use-tracker.sh      # File change tracking
├── ralph-iteration-guard.sh      # Max iterations/runtime
├── ralph-stuck-detector.sh       # Stuck detection
├── ralph-quality-gate.sh         # Test/lint gates
├── ralph-context-sync.sh         # Dev-docs persistence
├── error-handling-reminder.ts    # Error handling patterns
├── package.json                  # Dependencies (tsx, typescript)
├── tsconfig.json                 # TypeScript config
├── CONFIG.md                     # Additional configuration docs
└── README.md                     # This file
```

---

## Troubleshooting

### UserPromptSubmit hook error

**Cause:** Dependencies not installed

**Fix:**
```bash
cd .claude/hooks && bun install
```

### Hook not running

1. Check hook is registered in correct settings.json
2. For project hooks: `.claude/settings.json`
3. For global hooks: `~/.claude/settings.json`
4. Verify script is executable: `chmod +x script.sh`

### PreToolUse not blocking

1. Check matcher matches tool name exactly
2. Verify grep pattern is correct
3. Ensure `exit 2` is used for blocking
4. Test pattern: `echo '{"command":"npm install"}' | grep -qE 'pattern'`

### PostToolUse not triggering

1. Check matcher regex: `Edit|MultiEdit|Write`
2. Verify tool name matches (case-sensitive)

---

## Learn More

- **Skills system:** [../skills/README.md](../skills/README.md)
- **skill-rules.json:** [../skills/skill-rules.json](../skills/skill-rules.json)
- **Ralph plugin:** [../plugins/ralph-wiggum/README.md](../plugins/ralph-wiggum/README.md)
- **Rules system:** [../rules/README.md](../rules/README.md)
