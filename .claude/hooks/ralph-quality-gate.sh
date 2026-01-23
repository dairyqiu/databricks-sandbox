#!/bin/bash
set -e

# Ralph Quality Gate Hook
# Runs quality checks (tests, types, lint) before allowing loop continuation
# Acts as backpressure to ensure quality is maintained during autonomous work

STATE_FILE="$CLAUDE_PROJECT_DIR/.claude/ralph-state.json"

# Check if Ralph is active with quality gates enabled
if [[ ! -f "$STATE_FILE" ]]; then
    exit 0
fi

state=$(cat "$STATE_FILE")
active=$(echo "$state" | jq -r '.active // false')
quality_gates=$(echo "$state" | jq -r '.qualityGates // false')

if [[ "$active" != "true" ]] || [[ "$quality_gates" != "true" ]]; then
    exit 0
fi

PROJECT_ROOT="$CLAUDE_PROJECT_DIR"
GATE_RESULTS=""
GATE_PASSED=true

echo "Running quality gates..."

# --- TypeScript Type Check ---
if [[ -f "$PROJECT_ROOT/tsconfig.json" ]]; then
    echo "  [TypeScript] Checking types..."
    if npx tsc --noEmit 2>/dev/null; then
        GATE_RESULTS="${GATE_RESULTS}TypeScript: ✅ PASS\n"
    else
        GATE_RESULTS="${GATE_RESULTS}TypeScript: ❌ FAIL (type errors)\n"
        GATE_PASSED=false
    fi
fi

# --- Tests ---
if [[ -f "$PROJECT_ROOT/package.json" ]]; then
    if grep -q '"test"' "$PROJECT_ROOT/package.json" 2>/dev/null; then
        echo "  [Tests] Running test suite..."

        # Determine package manager
        if [[ -f "$PROJECT_ROOT/pnpm-lock.yaml" ]]; then
            test_cmd="pnpm test"
        elif [[ -f "$PROJECT_ROOT/yarn.lock" ]]; then
            test_cmd="yarn test"
        else
            test_cmd="npm test"
        fi

        if $test_cmd --silent 2>/dev/null; then
            GATE_RESULTS="${GATE_RESULTS}Tests: ✅ PASS\n"
        else
            GATE_RESULTS="${GATE_RESULTS}Tests: ❌ FAIL\n"
            GATE_PASSED=false
        fi
    fi
fi

# --- Lint ---
if [[ -f "$PROJECT_ROOT/package.json" ]]; then
    if grep -q '"lint"' "$PROJECT_ROOT/package.json" 2>/dev/null; then
        echo "  [Lint] Checking code style..."

        if [[ -f "$PROJECT_ROOT/pnpm-lock.yaml" ]]; then
            lint_cmd="pnpm lint"
        elif [[ -f "$PROJECT_ROOT/yarn.lock" ]]; then
            lint_cmd="yarn lint"
        else
            lint_cmd="npm run lint"
        fi

        if $lint_cmd --silent 2>/dev/null; then
            GATE_RESULTS="${GATE_RESULTS}Lint: ✅ PASS\n"
        else
            GATE_RESULTS="${GATE_RESULTS}Lint: ❌ FAIL\n"
            GATE_PASSED=false
        fi
    fi
fi

# --- Build (optional, heavier check) ---
# Uncomment to enable build gate
# if [[ -f "$PROJECT_ROOT/package.json" ]]; then
#     if grep -q '"build"' "$PROJECT_ROOT/package.json" 2>/dev/null; then
#         echo "  [Build] Verifying build..."
#         if npm run build --silent 2>/dev/null; then
#             GATE_RESULTS="${GATE_RESULTS}Build: ✅ PASS\n"
#         else
#             GATE_RESULTS="${GATE_RESULTS}Build: ❌ FAIL\n"
#             GATE_PASSED=false
#         fi
#     fi
# fi

# Update state with gate results
tmp="${STATE_FILE}.tmp"
if [[ "$GATE_PASSED" == "true" ]]; then
    jq '.testsStatus = "pass" | .lastQualityGateResult = "pass"' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"
    echo ""
    echo "Quality Gates: ✅ ALL PASSED"
    echo -e "$GATE_RESULTS"
    exit 0
else
    jq '.testsStatus = "fail" | .lastQualityGateResult = "fail"' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"
    echo ""
    echo "Quality Gates: ❌ SOME FAILED"
    echo -e "$GATE_RESULTS"
    echo ""
    echo "The Ralph loop will continue, but please address these issues."
    echo "Consider using /cancel-ralph if quality is degrading."

    # We don't block here - just warn. The loop can continue but issues are logged.
    # To make gates blocking, uncomment the next line:
    # exit 1
    exit 0
fi
