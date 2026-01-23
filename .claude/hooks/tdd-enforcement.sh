#!/bin/bash
# TDD Enforcement Hook (PreToolUse)
# Blocks source code edits if no test file exists
#
# Exit codes:
#   0 - Allow silently
#   1 - Allow with warning
#   2 - Block the operation

# Parse file path from tool input
FILE_PATH=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.file_path // empty')

# Exit if no file path (not a file operation)
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Get project root
PROJECT_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Skip if not a source file
if [[ ! "$FILE_PATH" =~ \.(ts|tsx|js|jsx)$ ]]; then
    exit 0
fi

# Skip test files themselves
if [[ "$FILE_PATH" =~ \.(test|spec|integration\.test)\.(ts|tsx|js|jsx)$ ]]; then
    exit 0
fi

# Skip __tests__ directory
if [[ "$FILE_PATH" =~ __tests__ ]]; then
    exit 0
fi

# Skip configuration files
if [[ "$FILE_PATH" =~ (config|\.config)\.(ts|js)$ ]]; then
    exit 0
fi

# Skip type definition files
if [[ "$FILE_PATH" =~ \.d\.ts$ ]]; then
    exit 0
fi

# Get base name without extension
BASE_DIR=$(dirname "$FILE_PATH")
FILE_NAME=$(basename "$FILE_PATH")
NAME_WITHOUT_EXT="${FILE_NAME%.*}"
EXT="${FILE_NAME##*.}"

# Check for various test file patterns
UNIT_TEST_1="${BASE_DIR}/${NAME_WITHOUT_EXT}.test.${EXT}"
UNIT_TEST_2="${BASE_DIR}/${NAME_WITHOUT_EXT}.spec.${EXT}"
INT_TEST="${BASE_DIR}/${NAME_WITHOUT_EXT}.integration.test.${EXT}"
JEST_TEST="${BASE_DIR}/__tests__/${NAME_WITHOUT_EXT}.test.${EXT}"

# Also check with .ts extension if .tsx
if [[ "$EXT" == "tsx" ]]; then
    UNIT_TEST_TS="${BASE_DIR}/${NAME_WITHOUT_EXT}.test.ts"
    INT_TEST_TS="${BASE_DIR}/${NAME_WITHOUT_EXT}.integration.test.ts"
fi

# Check if any test file exists
TEST_EXISTS=false

for TEST_FILE in "$UNIT_TEST_1" "$UNIT_TEST_2" "$INT_TEST" "$JEST_TEST" "$UNIT_TEST_TS" "$INT_TEST_TS"; do
    if [[ -n "$TEST_FILE" && -f "$TEST_FILE" ]]; then
        TEST_EXISTS=true
        break
    fi
done

# If no test exists, block the edit
if [[ "$TEST_EXISTS" == "false" ]]; then
    cat << EOF

TDD VIOLATION: No test file for $FILE_PATH

Integration-First TDD requires tests BEFORE implementation.

Create one of these test files first:
  Integration: ${BASE_DIR}/${NAME_WITHOUT_EXT}.integration.test.${EXT} (recommended)
  Unit:        ${BASE_DIR}/${NAME_WITHOUT_EXT}.test.${EXT}

The "Walking Skeleton" approach:
1. Write integration test that exercises the full flow
2. Create scaffold (compiles but fails)
3. Write unit tests for complex logic
4. Implement to make tests pass

Run /tdd to start the proper workflow.

EOF
    exit 2  # Block
fi

# Test exists, allow the edit
exit 0
