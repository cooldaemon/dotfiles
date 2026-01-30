---
name: testing-principles
description: Core testing principles for any language. Use when writing tests, reviewing test code, or discussing testing strategy.
---

# Testing Principles

## Test Pyramid (No Overlap Strategy)

Avoid duplication - write appropriate tests at each layer:

1. **E2E Tests** (ATDD approach, critical flows)
   - Critical user flows (main success + key error scenarios)
   - Use Gherkin (.feature files) with Given-When-Then format
   - Use Scenario Outline + Examples table for multiple cases
   - Write scenarios BEFORE implementation (ATDD)

2. **Integration Tests** (majority of tests)
   - API endpoints, database operations
   - Edge cases and boundary conditions not covered by E2E
   - Component interactions

3. **Unit Tests** (as needed)
   - Pure logic not coverable by Integration tests
   - Utility functions, complex calculations

## Test-Driven Development

MANDATORY workflow:
1. Write test first (RED)
2. Run test - it should FAIL
3. Write minimal implementation (GREEN)
4. Run test - it should PASS
5. Refactor using `/refactor-code` command (IMPROVE)
6. Verify tests still pass

## Test Structure (AAA Pattern)

Every test should follow Arrange-Act-Assert:

```
// Arrange - Set up test data and conditions
// Act - Execute the code under test
// Assert - Verify the expected outcome
```

Keep tests focused: one behavior per test.

## Common Testing Mistakes

### Test User-Visible Behavior, Not Implementation

```typescript
// ❌ WRONG: Testing internal state
expect(component.state.count).toBe(5)

// ✅ CORRECT: Test what users see
expect(screen.getByText('Count: 5')).toBeInTheDocument()
```

### Use Semantic Selectors, Not Brittle CSS

```typescript
// ❌ WRONG: Breaks easily
await page.click('.css-class-xyz')

// ✅ CORRECT: Resilient to changes
await page.click('button:has-text("Submit")')
await page.click('[data-testid="submit-button"]')
```

### Keep Tests Independent

```typescript
// ❌ WRONG: Tests depend on each other
test('creates user', () => { /* ... */ })
test('updates same user', () => { /* depends on previous */ })

// ✅ CORRECT: Each test sets up its own data
test('creates user', () => { const user = createTestUser() })
test('updates user', () => { const user = createTestUser() })
```

## Quality Checklist

- [ ] Tests cover acceptance criteria
- [ ] Scenario Outline + Examples cover edge cases
- [ ] Tests are independent (no shared state)
- [ ] Test names describe the behavior being tested
- [ ] Tests verify user-visible behavior, not implementation
- [ ] Selectors are semantic (text, role, data-testid)
