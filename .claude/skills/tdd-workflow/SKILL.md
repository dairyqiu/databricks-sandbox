---
name: tdd-workflow
description: Use this skill when writing new features, fixing bugs, or refactoring code. Enforces Integration-First TDD with 80%+ coverage.
---

# Integration-First TDD Workflow

This skill ensures all code development follows the "Walking Skeleton" TDD approach.

## Philosophy: Integration-First

```
Traditional TDD:     Unit Tests → Integration Tests → Implementation
Integration-First:   Integration Skeleton → Unit Tests → Implementation → Wire Up
```

**Why Integration-First?**
- Prevents "Mock Fantasy Land" where unit tests pass but the system fails
- Validates real database queries, API contracts, and service wiring
- Catches integration bugs early, not in production

## The Sandwich Method

```
1. TOP BUN (Integration):  "Happy Path" test touching DB/API
2. MEAT (Unit):            Isolated tests for complex logic
3. BOTTOM BUN (Refactor):  Cleanup and optimize
```

## When to Activate

- Writing new features or functionality
- Fixing bugs or issues
- Refactoring existing code
- Adding API endpoints
- Creating new components

## TDD Workflow Steps

### Phase 1: Walking Skeleton (Integration)

**Goal:** Verify the system wires together correctly.

1. **Context Scan** - Read schema files, API definitions, existing types
2. **Write Integration Test** - Full flow (Controller → Service → DB)
   - **STRICT:** Do NOT mock database or internal services
   - **STRICT:** DO mock external HTTP (Stripe, Twilio, OpenAI)
3. **Scaffold** - Create exports with dummy data (compiles but fails)

```typescript
// src/services/checkout.integration.test.ts
describe('Checkout Flow', () => {
  it('creates order with valid payment', async () => {
    // This test hits REAL database (test DB)
    const user = await createTestUser()
    const cart = await createTestCart(user.id)

    const result = await checkoutService.processCheckout(cart.id)

    expect(result.order).toBeDefined()
    expect(result.order.status).toBe('paid')

    // Verify in database
    const savedOrder = await db.orders.findUnique({ where: { id: result.order.id }})
    expect(savedOrder).toBeTruthy()
  })
})
```

### Phase 2: Logic Hardening (Unit)

**Goal:** Verify complex internal rules.

1. **Identify Complexity** - Math, string manipulation, branching
2. **Write Unit Tests** - NOW you can mock. Test edge cases.
3. **Implement Logic** - Pass unit tests

```typescript
// src/utils/pricing.test.ts
describe('calculateDiscount', () => {
  it('applies 10% for orders over $100', () => {
    expect(calculateDiscount(150)).toBe(15)
  })

  it('returns 0 for orders under $100', () => {
    expect(calculateDiscount(50)).toBe(0)
  })

  it('caps discount at $50', () => {
    expect(calculateDiscount(1000)).toBe(50)
  })
})
```

### Phase 3: Green Connection

1. Wire tested logic into skeleton
2. Run integration test - should pass
3. Verify 80%+ coverage

## Mocking Rules (CRITICAL)

| Dependency | Action | Why |
|------------|--------|-----|
| My Database | **DO NOT MOCK** | Test real SQL/Schema |
| My Internal Service | **DO NOT MOCK** in integration | Verify wiring |
| External SaaS (Stripe/OpenAI) | **MOCK** | Don't hit external APIs |
| System Time | **MOCK** | Deterministic tests |
| File System | Case by case | Mock for unit, real for integration |

### When to Mock Internal Code

- **Integration tests:** Never mock your own code
- **Unit tests:** Mock dependencies of the unit being tested

```typescript
// WRONG: Mocking internal service in integration test
jest.mock('@/services/orderService')  // NO!

// CORRECT: Mock external API only
jest.mock('@/lib/stripe', () => ({
  createPaymentIntent: jest.fn(() => Promise.resolve({ id: 'pi_test' }))
}))
```

## Test File Organization

```
src/
├── services/
│   ├── checkout.ts
│   ├── checkout.integration.test.ts   # Integration (hits DB)
│   └── checkout.test.ts               # Unit (if complex logic)
├── utils/
│   ├── pricing.ts
│   └── pricing.test.ts                # Pure unit tests
└── e2e/
    └── checkout-flow.spec.ts          # Playwright E2E
```

## Coverage Requirements

- **80% minimum** overall
- **100% required** for:
  - Financial calculations
  - Authentication logic
  - Security-critical code
  - Core business rules

## Test Quality Checklist

Before marking tests complete:

- [ ] Integration test hits real database (test DB)
- [ ] No mocking internal services in integration tests
- [ ] External APIs are mocked (Stripe, OpenAI, etc.)
- [ ] Unhappy paths tested (validation errors, 404s)
- [ ] Edge cases covered (null, empty, max values)
- [ ] Test names describe the behavior
- [ ] Tests are independent (no shared state)
- [ ] Coverage is 80%+ (verify with coverage report)

## Common Mistakes to Avoid

### Mock Fantasy Land

```typescript
// BAD: Everything mocked - proves nothing
jest.mock('@/db')
jest.mock('@/services/user')
jest.mock('@/services/order')
// Test passes but real system fails!
```

### Testing Implementation Details

```typescript
// BAD: Tests internal state
expect(service.internalCache.size).toBe(3)

// GOOD: Tests observable behavior
expect(await service.getUsers()).toHaveLength(3)
```

### Brittle Selectors

```typescript
// BAD: Breaks on CSS changes
await page.click('.css-1abc2de')

// GOOD: Semantic selectors
await page.click('button:has-text("Submit")')
await page.click('[data-testid="submit-btn"]')
```

## Running Tests

```bash
# Run all tests
bun test

# Run with coverage
bun test --coverage

# Run specific test file
bun test src/services/checkout.integration.test.ts

# Watch mode
bun test --watch
```

## Success Metrics

- 80%+ code coverage
- All tests passing (green)
- Integration tests use real database
- External APIs mocked
- Tests catch bugs before production

---

**Remember**: Integration tests first, unit tests second. Don't mock what you own. Tests are your safety net for confident refactoring.
