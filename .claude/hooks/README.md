# Essential Hooks

The two hooks that power the auto-activation system.

---

## What's Included

This directory contains **2 essential hooks** that enable skill auto-activation and file tracking:

1. **skill-activation-prompt** - Auto-suggests skills based on context
2. **post-tool-use-tracker** - Tracks file changes for smarter suggestions

These hooks require **no customization** and work out of the box for any project.

---

## How It Works

### skill-activation-prompt (UserPromptSubmit)

**Runs:** Before Claude sees your prompt

**Does:**
1. Reads [skill-rules.json](../skills/skill-rules.json)
2. Matches your prompt against trigger keywords and patterns
3. Checks which files you're working with
4. Injects skill suggestions into Claude's context

**Result:** Skills auto-suggest when relevant (e.g., typing "backend" suggests backend-dev-guidelines)

### post-tool-use-tracker (PostToolUse)

**Runs:** After you edit, write, or create files

**Does:**
1. Detects project structure automatically
2. Tracks which files changed
3. Stores context for future skill suggestions

**Result:** File-based skill triggering works (e.g., editing `routes/users.ts` suggests route-tester)

---

## Installation

These hooks are already configured in [settings.json](../settings.json). To use in a new project:

```bash
# 1. Copy the hooks directory
cp -r .claude/hooks/ /path/to/your-project/.claude/

# 2. Install dependencies
cd /path/to/your-project/.claude/hooks/
npm install

# 3. Make scripts executable
chmod +x skill-activation-prompt.sh
chmod +x post-tool-use-tracker.sh
```

**That's it!** The hooks are now active.

---

## Configuration

### settings.json

Both hooks are registered in [settings.json](../settings.json):

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/skill-activation-prompt.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use-tracker.sh"
          }
        ]
      }
    ]
  }
}
```

### skill-rules.json

The skill-activation-prompt hook reads [skill-rules.json](../skills/skill-rules.json) to determine which skills to suggest.

**Example configuration:**
```json
{
  "skills": {
    "skill-developer": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["skill", "create skill", "add skill"],
        "intentPatterns": ["(create|add|modify).*?skill"]
      }
    }
  }
}
```

When you add skills from [optional-components/skills/](../../optional-components/skills/), add their configurations to this file.

---

## Dependencies

Both hooks use TypeScript and require npm packages:

```json
{
  "dependencies": {
    "@types/node": "^20.x.x",
    "typescript": "^5.x.x",
    "tsx": "^4.x.x"
  }
}
```

Install with: `npm install` in this directory.

---

## Advanced Hooks

Want more automation? See [optional-components/hooks/](../../optional-components/hooks/) for:

- **TypeScript validation** - Run `tsc --noEmit` after TS file edits
- **Auto-formatting** - Prettier on save
- **Git push gates** - Manual approval before pushing
- **Console.log detection** - Warn about debugging statements
- **TMux enforcement** - Ensure dev servers run in TMux

These require customization for your project structure.

---

## Troubleshooting

### Skills aren't auto-suggesting

1. **Check hook is registered:** Look at [settings.json](../settings.json)
2. **Verify dependencies:** Run `npm install` in this directory
3. **Test manually:** Run `./skill-activation-prompt.sh` (should run without errors)
4. **Check skill-rules.json:** Ensure your skill is configured with triggers

### Hook errors in console

1. **Make executable:** `chmod +x *.sh` in this directory
2. **Check paths:** Hooks use `$CLAUDE_PROJECT_DIR` which should resolve correctly
3. **Verify TypeScript:** Run `npx tsx skill-activation-prompt.ts` to test

### File tracking not working

1. **Check PostToolUse hook:** Registered in settings.json with correct matcher
2. **Verify post-tool-use-tracker.sh:** Should be executable
3. **Test edit:** Make a file edit and check if hook runs

---

## How Hooks Work

### UserPromptSubmit

```
User types prompt → Hook runs → Modifies prompt → Claude sees modified version
```

**Use cases:**
- Inject skill suggestions
- Add context from files
- Enforce guardrails

### PostToolUse

```
Claude uses tool → Tool completes → Hook runs → Can update state
```

**Use cases:**
- Track file changes
- Run validators (TypeScript, linters)
- Format code automatically

### PreToolUse

```
Claude wants to use tool → Hook runs → Can block or modify → Tool executes
```

**Use cases:**
- Block dangerous operations
- Require confirmations (git push)
- Validate inputs

### Stop

```
User stops Claude → Hook runs → Can perform cleanup
```

**Use cases:**
- Run final validations
- Check for debug code
- Build verification

---

## File Overview

```
hooks/
├── skill-activation-prompt.sh    # Shell wrapper for TypeScript
├── skill-activation-prompt.ts    # Main skill activation logic
├── post-tool-use-tracker.sh      # Shell wrapper
├── package.json                  # npm dependencies
├── package-lock.json             # Lock file
├── tsconfig.json                 # TypeScript config
└── README.md                     # This file
```

---

## Learn More

- **Skill activation:** See [../skills/README.md](../skills/README.md)
- **skill-rules.json:** See [../skills/skill-rules.json](../skills/skill-rules.json)
- **Advanced hooks:** See [../../optional-components/hooks/README.md](../../optional-components/hooks/README.md)
- **Main guide:** See [../../README.md](../../README.md)
