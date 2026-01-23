---
description: Verify TDD compliance for recent changes
---

# TDD Check Command

Verify that recent code changes follow TDD practices.

## What This Command Does

1. Get list of recently changed source files
2. Verify each has a corresponding test file
3. Run test coverage report
4. Report compliance status

## Execute

### Step 1: Get Changed Files

Run git command to get recently modified source files:
```bash
git diff --name-only HEAD~5 -- '*.ts' '*.tsx' '*.js' '*.jsx' | grep -v '\.test\.' | grep -v '\.spec\.' | grep -v '__tests__'
```

Or for unstaged changes:
```bash
git diff --name-only -- '*.ts' '*.tsx' '*.js' '*.jsx' | grep -v '\.test\.' | grep -v '\.spec\.'
```

### Step 2: Check for Test Files

For each source file, verify existence of test file:

| Source File | Expected Test File(s) |
|-------------|----------------------|
| `src/service.ts` | `src/service.test.ts` OR `src/service.integration.test.ts` |
| `src/utils/calc.ts` | `src/utils/calc.test.ts` |
| `lib/api.ts` | `lib/api.test.ts` OR `lib/api.integration.test.ts` |

Check patterns:
- `<name>.test.ts` (unit test)
- `<name>.spec.ts` (unit test)
- `<name>.integration.test.ts` (integration test)
- `__tests__/<name>.test.ts` (Jest convention)

### Step 3: Run Coverage Report

Execute test coverage:
```bash
# For bun/vitest
bun test --coverage

# For npm/jest
npm test -- --coverage --silent
```

Parse coverage output for:
- Lines covered percentage
- Branches covered percentage
- Functions covered percentage
- Statements covered percentage

### Step 4: Generate Report

Output format:
```
TDD Compliance Report
=====================

Changed Source Files: 5
├── ✅ src/services/auth.ts → auth.test.ts
├── ✅ src/services/user.ts → user.integration.test.ts
├── ⚠️  src/utils/format.ts → MISSING TEST
├── ✅ src/components/Button.tsx → Button.test.tsx
└── ✅ lib/api/client.ts → client.test.ts

Test Coverage:
├── Lines:      87% ✅ (threshold: 80%)
├── Branches:   82% ✅ (threshold: 80%)
├── Functions:  91% ✅ (threshold: 80%)
└── Statements: 85% ✅ (threshold: 80%)

Missing Tests:
1. src/utils/format.ts
   Create: src/utils/format.test.ts
   Or:     src/utils/format.integration.test.ts

Overall Status: ⚠️ PARTIAL COMPLIANCE
- 4/5 files have tests (80%)
- Coverage meets threshold
- Action: Add test for format.ts
```

## Exit Codes (for CI/CD)

- `0` - Full compliance (all files have tests, coverage met)
- `1` - Missing tests
- `2` - Coverage below threshold
- `3` - Both issues

## Options

```
/tdd-check              # Check recent changes (HEAD~5)
/tdd-check --staged     # Check only staged files
/tdd-check --all        # Check all source files
/tdd-check --strict     # Fail on any missing test
```

## Integration with CI

Add to GitHub Actions:
```yaml
- name: TDD Compliance Check
  run: |
    # Claude Code will run /tdd-check
    # Or use a script that mimics the logic
```

## Quick Fix

If tests are missing, suggest running:
```
/tdd <feature-name>
```

To scaffold tests for missing files using the Integration-First TDD approach.
