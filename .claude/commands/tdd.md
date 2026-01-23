---
description: Enforce test-driven development workflow. Scaffold interfaces, generate tests FIRST, then implement minimal code to pass. Ensure 80%+ coverage.
---

# TDD Command

Invokes **tdd-guide** agent for Integration-First TDD methodology.

## What This Command Does

1. **Integration Skeleton** - Write integration test first (RED)
2. **Scaffold** - Empty functions that compile but fail
3. **Unit Tests** - Test complex logic in isolation
4. **Implement** - Write minimal code to pass (GREEN)
5. **Refactor** - Cleanup while keeping tests green (REFACTOR)
6. **Verify** - Ensure 80%+ coverage

## The Sandwich Method

```
┌─────────────────────────────────────────────────────────┐
│  TOP BUN: Integration Test (hits real DB)               │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│  MEAT: Unit Tests (for complex logic)                   │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│  BOTTOM BUN: Refactor (tests stay green)                │
└─────────────────────────────────────────────────────────┘
```

## Mocking Rules (CRITICAL)

| Dependency | Action |
|------------|--------|
| My Database | **DO NOT MOCK** - Test real SQL/Schema |
| My Internal Service | **DO NOT MOCK** in integration |
| External SaaS (Stripe/OpenAI) | **MOCK** |
| System Time | **MOCK** |

## When to Use

Use `/tdd` when:
- Implementing new features
- Adding new functions/components
- Fixing bugs (write test that reproduces bug first)
- Refactoring existing code
- Building critical business logic

## Workflow

### Phase 1: Walking Skeleton (Integration)

```typescript
// src/services/checkout.integration.test.ts
describe('Checkout Flow', () => {
  it('creates order with valid payment', async () => {
    // This hits REAL database
    const user = await createTestUser()
    const cart = await createTestCart(user.id)

    const result = await checkoutService.processCheckout(cart.id)

    expect(result.order.status).toBe('paid')

    // Verify in database
    const saved = await db.orders.findUnique({ where: { id: result.order.id }})
    expect(saved).toBeTruthy()
  })
})
```

### Phase 2: Scaffold

```typescript
// src/services/checkout.ts
export async function processCheckout(cartId: string) {
  throw new Error('Not implemented')
}
```

### Phase 3: Unit Tests (Complex Logic)

```typescript
// src/utils/pricing.test.ts
describe('calculateDiscount', () => {
  it('applies 10% for orders over $100', () => {
    expect(calculateDiscount(150)).toBe(15)
  })
})
```

### Phase 4: Implement

Write minimal code to make tests pass.

### Phase 5: Verify Coverage

```bash
bun test --coverage
# Must be 80%+
```

## TDD Cycle

```
RED → GREEN → REFACTOR → REPEAT

RED:      Write a failing test
GREEN:    Write minimal code to pass
REFACTOR: Improve code, keep tests passing
REPEAT:   Next feature/scenario
```

## Example Session

```
User: /tdd checkout flow

Agent (tdd-guide):

Phase 1: Integration Test
✅ Created: src/services/checkout.integration.test.ts
   - "creates order with valid payment"
   - "rejects expired card"
   - "handles insufficient inventory"

Phase 2: Scaffold
✅ Created: src/services/checkout.ts (throws NotImplemented)

Phase 3: Unit Tests
✅ Created: src/utils/pricing.test.ts
   - "calculates subtotal correctly"
   - "applies discount for large orders"
   - "adds tax by region"

Phase 4: Implementation
✅ Implemented all functions

Phase 5: Verification
✅ All tests passing (9/9)
✅ Coverage: 92%
```

## Best Practices

**DO:**
- ✅ Write integration test FIRST (hits real DB)
- ✅ Create scaffold that compiles but fails
- ✅ Mock only external APIs (Stripe, OpenAI)
- ✅ Run tests after each change
- ✅ Refactor only after green

**DON'T:**
- ❌ Mock your own database
- ❌ Mock your internal services (in integration)
- ❌ Write implementation before tests
- ❌ Skip the scaffold step
- ❌ Ignore failing tests

## Coverage Requirements

- **80% minimum** for all code
- **100% required** for:
  - Financial calculations
  - Authentication logic
  - Security-critical code

## Related Commands

- `/tdd-check` - Verify TDD compliance
- `/build-fix` - Fix build errors after TDD
- `/code-review` - Review implementation

## Related Agent

This command invokes the `tdd-guide` agent.
