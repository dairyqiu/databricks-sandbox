# Optional Hooks

**Advanced automation hooks to add to your project as needed**

This directory contains 4 advanced hooks from the original repository plus hooks.json from everything-claude-code. These provide optional automation like TypeScript validation, build checking, error handling reminders, and more.

---

## What Are Hooks?

Hooks are shell commands that execute in response to events during Claude Code sessions:

**Hook Types:**
- **PreToolUse** - Before tool execution (validation, parameter modification)
- **PostToolUse** - After tool execution (auto-format, checks)
- **UserPromptSubmit** - Before Claude sees user prompts (skill activation)
- **Stop** - When session ends (final verification)

**Essential hooks** (in base template):
- skill-activation-prompt (UserPromptSubmit)
- post-tool-use-tracker (PostToolUse)

**Optional hooks** (in this directory):
- Advanced automation requiring customization

---

## Quick Reference

| Hook | Type | Purpose | Source |
|------|------|---------|--------|
| [tsc-check.sh](#tsc-checksh) | Stop | TypeScript validation on session end | Original |
| [trigger-build-resolver.sh](#trigger-build-resolversh) | Stop | Auto-launch build-error-resolver | Original |
| [error-handling-reminder.sh](#error-handling-remindersh) | PostToolUse | Remind about error handling | Original |
| [stop-build-check-enhanced.sh](#stop-build-check-enhancedsh) | Stop | Enhanced build verification | Original |
| [hooks.json](#hooksjson) | Config | Additional hook examples | everything-cc |

---

## From Original Repository

### tsc-check.sh

**Type:** Stop hook

**Purpose:** Run TypeScript type checking when session ends to catch type errors.

**When It Runs:** After user stops Claude Code session (before exit)

**What It Does:**
1. Runs `tsc --noEmit` to check types without emitting files
2. Reports any TypeScript errors found
3. Prevents session end if critical errors exist (optional configuration)

**Requirements:**
- TypeScript project with `tsconfig.json`
- `tsc` command available

**Integration:**

```bash
# 1. Copy the hook
cp optional-components/hooks/tsc-check.sh .claude/hooks/

# 2. Make it executable
chmod +x .claude/hooks/tsc-check.sh

# 3. Add to settings.json
```

Edit [.claude/settings.json](../../.claude/settings.json):

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/tsc-check.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:**

```bash
# Edit the hook to customize
vim .claude/hooks/tsc-check.sh

# Options:
# - Change tsconfig.json path
# - Modify error reporting format
# - Add --strict flag
# - Skip certain directories
```

**Use Cases:**
- Catch type errors before committing
- Ensure type safety across codebase
- Prevent type regressions

---

### trigger-build-resolver.sh

**Type:** Stop hook

**Purpose:** Automatically launch build-error-resolver agent if build is failing when session ends.

**When It Runs:** After user stops Claude Code session

**What It Does:**
1. Runs project build command
2. If build fails, automatically launches **build-error-resolver agent**
3. Agent analyzes errors and suggests fixes
4. Optionally blocks session end until build succeeds

**Requirements:**
- Build command configured (npm, pnpm, yarn, etc.)
- build-error-resolver agent installed

**Integration:**

```bash
# 1. Copy the hook
cp optional-components/hooks/trigger-build-resolver.sh .claude/hooks/

# 2. Copy the agent if not already present
cp optional-components/agents/build-error-resolver.md .claude/agents/

# 3. Make hook executable
chmod +x .claude/hooks/trigger-build-resolver.sh

# 4. Add to settings.json
```

Edit [.claude/settings.json](../../.claude/settings.json):

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/trigger-build-resolver.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:**

```bash
vim .claude/hooks/trigger-build-resolver.sh

# Configure:
# - Build command (npm run build, pnpm build, etc.)
# - Working directory
# - Error threshold (when to trigger agent)
# - Blocking behavior
```

**Use Cases:**
- Ensure builds pass before ending session
- Automated build troubleshooting
- Continuous build verification

---

### error-handling-reminder.sh

**Type:** PostToolUse hook

**Purpose:** Remind to add error handling after writing code without try/catch blocks.

**When It Runs:** After Edit/Write tool usage

**What It Does:**
1. Scans edited files for async functions
2. Checks if proper error handling exists
3. Reminds to add try/catch if missing
4. Provides error handling pattern suggestions

**Requirements:**
- TypeScript or JavaScript project

**Integration:**

```bash
# 1. Copy the hook
cp optional-components/hooks/error-handling-reminder.sh .claude/hooks/

# 2. Make it executable
chmod +x .claude/hooks/error-handling-reminder.sh

# 3. Add to settings.json
```

Edit [.claude/settings.json](../../.claude/settings.json):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/error-handling-reminder.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:**

```bash
vim .claude/hooks/error-handling-reminder.sh

# Configure:
# - Patterns to detect (async, Promise, etc.)
# - Exception patterns (test files, types)
# - Reminder message format
```

**Use Cases:**
- Enforce error handling standards
- Catch missing try/catch blocks
- Improve code reliability

---

### stop-build-check-enhanced.sh

**Type:** Stop hook

**Purpose:** Enhanced build and test verification before session end.

**When It Runs:** After user stops Claude Code session

**What It Does:**
1. Runs full build process
2. Executes test suite
3. Checks test coverage threshold
4. Verifies no console.log statements
5. Runs linter
6. Reports all issues before exit

**Requirements:**
- Build script configured
- Test suite setup
- Coverage tool (jest, vitest, etc.)
- Linter (eslint, etc.)

**Integration:**

```bash
# 1. Copy the hook
cp optional-components/hooks/stop-build-check-enhanced.sh .claude/hooks/

# 2. Make it executable
chmod +x .claude/hooks/stop-build-check-enhanced.sh

# 3. Add to settings.json
```

Edit [.claude/settings.json](../../.claude/settings.json):

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/stop-build-check-enhanced.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:**

```bash
vim .claude/hooks/stop-build-check-enhanced.sh

# Configure:
# - Build command
# - Test command
# - Coverage threshold (default 80%)
# - Linter command
# - Which checks to enable/disable
```

**Use Cases:**
- Comprehensive pre-commit verification
- Enforce quality standards
- Prevent incomplete work from ending session

---

## From everything-claude-code

### hooks.json

**Purpose:** Example hook configurations from everything-claude-code repository.

**Contents:**
- TMux reminder for long-running commands
- Git push review gates
- Documentation blocker
- PR creation logging
- Prettier auto-formatting
- TypeScript checking
- Console.log detection

**Integration:**

```bash
# View the example configurations
cat optional-components/hooks/hooks.json

# Extract specific hooks you want
# Adapt to your project structure
# Add to your .claude/settings.json
```

**Example Configurations from hooks.json:**

**TMux Reminder (PreToolUse):**
```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/tmux-reminder.sh"
        }
      ]
    }
  ]
}
```

**Git Push Review (PreToolUse):**
```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/git-push-review.sh"
        }
      ]
    }
  ]
}
```

**Auto-Formatting (PostToolUse):**
```json
{
  "PostToolUse": [
    {
      "matcher": "Edit|Write",
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/prettier-format.sh"
        }
      ]
    }
  ]
}
```

**Console.log Audit (Stop):**
```json
{
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "~/.claude/hooks/console-log-audit.sh"
        }
      ]
    }
  ]
}
```

---

## Hook Configuration Patterns

### Multiple Hooks on Same Event

You can run multiple hooks for the same event:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/tsc-check.sh"
          },
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/stop-build-check-enhanced.sh"
          }
        ]
      }
    ]
  }
}
```

### Conditional Hooks with Matchers

PostToolUse and PreToolUse hooks can use matchers:

```json
{
  "PostToolUse": [
    {
      "matcher": "Edit",
      "hooks": [
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/prettier-format.sh"
        }
      ]
    },
    {
      "matcher": "Write",
      "hooks": [
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/new-file-check.sh"
        }
      ]
    }
  ]
}
```

**Available Matchers:**
- `Edit` - Edit tool used
- `Write` - Write tool used
- `MultiEdit` - MultiEdit tool used
- `Bash` - Bash tool used
- `Edit|Write` - Either Edit or Write
- `*` - Any tool

---

## Creating Custom Hooks

### Hook Script Structure

```bash
#!/bin/bash

# Hook: custom-hook.sh
# Type: PostToolUse
# Purpose: Brief description

# Read tool use data from stdin (for PostToolUse/PreToolUse)
TOOL_DATA=$(cat)

# Your hook logic here
# ...

# Exit codes:
# 0 = Success, continue
# Non-zero = Error/warning
exit 0
```

### Example: TypeScript File Formatter

```bash
#!/bin/bash

# Hook: ts-formatter.sh
# Type: PostToolUse (Edit|Write)
# Purpose: Auto-format TypeScript files with Prettier

# Get the file path from tool data
FILE_PATH=$(echo "$TOOL_DATA" | jq -r '.file_path // empty')

# Only process .ts and .tsx files
if [[ "$FILE_PATH" =~ \.(ts|tsx)$ ]]; then
  echo "Formatting $FILE_PATH with Prettier..."
  npx prettier --write "$FILE_PATH"
fi

exit 0
```

### Example: Test Coverage Checker

```bash
#!/bin/bash

# Hook: coverage-check.sh
# Type: Stop
# Purpose: Verify test coverage meets threshold

COVERAGE_THRESHOLD=80

echo "Checking test coverage..."

# Run tests with coverage
npm run test:coverage > /tmp/coverage-output.txt 2>&1

# Extract coverage percentage
COVERAGE=$(grep -oP 'All files.*?\K\d+(?=\.\d+)' /tmp/coverage-output.txt)

if [ "$COVERAGE" -lt "$COVERAGE_THRESHOLD" ]; then
  echo "❌ Coverage is ${COVERAGE}%, below threshold of ${COVERAGE_THRESHOLD}%"
  exit 1
else
  echo "✅ Coverage is ${COVERAGE}%, meeting threshold"
  exit 0
fi
```

---

## Hook Best Practices

### 1. Keep Hooks Fast

Hooks run synchronously and block Claude:
- Use fast checks (< 2 seconds)
- Run expensive tasks asynchronously
- Provide progress indicators

### 2. Fail Gracefully

Hooks should not break Claude Code:
- Catch errors and report them
- Exit 0 for warnings (don't block)
- Exit non-zero only for critical failures

### 3. Make Hooks Configurable

Use environment variables or config files:

```bash
# Read config from .hook-config.json
CONFIG=$(cat .hook-config.json)
THRESHOLD=$(echo "$CONFIG" | jq -r '.coverage_threshold // 80')
```

### 4. Provide Clear Feedback

Users should understand what hooks are doing:
- Print clear messages
- Show progress for long operations
- Explain errors with actionable steps

### 5. Use $CLAUDE_PROJECT_DIR

Reference project files reliably:

```bash
# ✅ GOOD: Uses $CLAUDE_PROJECT_DIR
"command": "$CLAUDE_PROJECT_DIR/.claude/hooks/my-hook.sh"

# ❌ BAD: Assumes current directory
"command": "./.claude/hooks/my-hook.sh"
```

---

## Common Use Cases

### Pre-Commit Validation

Use Stop hooks to verify code before session ends:

```json
{
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/tsc-check.sh"
        },
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/run-tests.sh"
        },
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/lint-check.sh"
        }
      ]
    }
  ]
}
```

### Auto-Formatting on Save

Use PostToolUse hooks to format code automatically:

```json
{
  "PostToolUse": [
    {
      "matcher": "Edit|Write",
      "hooks": [
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/prettier-format.sh"
        }
      ]
    }
  ]
}
```

### Dangerous Operation Gates

Use PreToolUse hooks to require confirmation:

```bash
#!/bin/bash
# Hook: git-push-gate.sh

# Check if Bash command contains "git push"
if echo "$BASH_COMMAND" | grep -q "git push"; then
  # Require manual approval
  echo "⚠️  Git push detected. Please review changes before pushing."
  exit 1  # Block the operation
fi

exit 0
```

---

## Troubleshooting

### Hook Not Running

**Problem:** Hook doesn't execute when expected

**Solutions:**
1. **Check hook is registered** in settings.json
2. **Verify executable permissions**: `chmod +x .claude/hooks/*.sh`
3. **Check hook path** uses `$CLAUDE_PROJECT_DIR`
4. **Test hook manually**: `./.claude/hooks/my-hook.sh`
5. **Check for syntax errors** in hook script

### Hook Causing Errors

**Problem:** Hook execution fails and blocks Claude

**Solutions:**
1. **Review error message** in terminal
2. **Test hook in isolation**: Run the script directly
3. **Check dependencies** (npm, jq, etc.) are installed
4. **Verify file paths** are correct
5. **Add error handling** in hook script

### Hook Too Slow

**Problem:** Hooks are slowing down development

**Solutions:**
1. **Optimize hook logic** - reduce processing
2. **Run expensive tasks async** - don't block
3. **Add timeout limits** to prevent hanging
4. **Consider removing** if not valuable
5. **Use Stop hooks** instead of PostToolUse for heavy checks

### Hook Conflicts

**Problem:** Multiple hooks interfering with each other

**Solutions:**
1. **Order hooks carefully** in settings.json
2. **Check for file locking** issues
3. **Ensure hooks are idempotent**
4. **Use different matchers** to separate concerns

---

## Hook Ordering

Hooks run in the order specified in settings.json:

```json
{
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/first-hook.sh"
        },
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/second-hook.sh"
        },
        {
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/third-hook.sh"
        }
      ]
    }
  ]
}
```

**Execution Order:**
1. first-hook.sh runs
2. If exit 0, second-hook.sh runs
3. If exit 0, third-hook.sh runs
4. If any exit non-zero, sequence stops

---

## Security Considerations

### Hook Permissions

Hooks execute with full system access:
- Review hook scripts before running
- Use `.gitignore` to prevent accidental commits of sensitive hooks
- Avoid hardcoding credentials in hooks

### User Approval

For destructive operations, require user confirmation:

```bash
#!/bin/bash

# Check for destructive command
if echo "$COMMAND" | grep -q "rm -rf"; then
  echo "⚠️  Destructive command detected. Confirm? (y/n)"
  read -r CONFIRM
  if [ "$CONFIRM" != "y" ]; then
    exit 1  # Block operation
  fi
fi

exit 0
```

---

## Integration with Other Components

### Hooks + Agents

Hooks can trigger agents:

**Example:** trigger-build-resolver.sh launches build-error-resolver agent when build fails.

**Pattern:**
1. Hook detects condition (build failure)
2. Hook triggers agent via Claude Code API
3. Agent analyzes and fixes issue

### Hooks + Skills

Skills guide what hooks should check:

**Example:**
- **tdd-workflow skill** teaches test-driven development
- **Stop hook** verifies test coverage before session end

### Hooks + Rules

Rules establish standards, hooks enforce them:

**Example:**
- **security.md rule** requires "No console.log in production"
- **PostToolUse hook** detects console.log after edits

---

## Learn More

- **Essential hooks:** [../../.claude/hooks/README.md](../../.claude/hooks/README.md)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Hooks reference:** [../../.claude/rules/hooks.md](../../.claude/rules/hooks.md)
- **Main guide:** [../../README.md](../../README.md)
