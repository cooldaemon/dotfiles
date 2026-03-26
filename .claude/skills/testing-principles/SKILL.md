---
name: testing-principles
description: Use when writing tests or reviewing test code without a language-specific testing skill loaded.
durability: encoded-preference
---

# Testing Principles

## Test Level Selection (No Overlap Strategy)

Choose the **highest level** that covers the behavior. Avoid duplication across layers.

| Level | When to use | Imports |
|-------|-------------|---------|
| **E2E** (Gherkin + Playwright/Cypress) | UI-driven behavior, critical user flows. Use Gherkin with Given-When-Then, Scenario Outline + Examples for multiple cases. Write scenarios BEFORE implementation (ATDD). | None (browser interaction) |
| **Integration** (HTTP/CLI/public API) | System behavior without UI: API endpoints, database operations, edge cases not covered by E2E, component interactions. | Public entry points only (routes, CLI, exported API) |
| **Unit (behavioral)** | Pure function contracts NOT already covered by higher-level tests. Utility functions, complex calculations. | Public module exports |

### Unit Test Rules

Unit tests MUST test function **contracts** (input -> output), NEVER **structure** (call patterns, internal state). If a behavioral test already passes through the code path, do NOT add a unit test for the same path.

See "Behavioral Tests vs Structural Tests" section for red flags and guidance.

## Test-Driven Development

**Always write tests before implementation.** See `/tdd` command for the full RED-GREEN-REFACTOR workflow.

## Cross-US Test Safety Net

When implementing multiple User Stories sequentially, tests from earlier USs serve as the safety net for refactoring their code. Previously-committed code with passing tests is NOT frozen -- it is actively refactorable.

- Tests from US1 protect US1's behavior during US2's REFACTOR phase
- If tests stay GREEN after refactoring, the refactoring is safe
- Duplication across US boundaries is a refactoring target, same as duplication within a single US

## Characterization Tests (Legacy Code)

**Characterization tests capture what code actually does, not what it should do.** Write them before refactoring any untested legacy code.

**When to use**: REFACTOR phase needs to modify code that:
- Was written before the project adopted TDD
- Has no existing test coverage
- Would be risky to change without verification

### Anti-Patterns

| Anti-Pattern | Correct Approach |
|--------------|------------------|
| Refactoring untested code without characterization tests | Write characterization tests first, confirm GREEN, then refactor |
| Writing characterization tests for what code *should* do | Capture what code *actually* does (warts and all) |
| Skipping characterization tests for "simple" legacy code | If it has no tests, it needs characterization tests before refactoring |

## Test Structure (AAA Pattern)

Every test should follow Arrange-Act-Assert:

```
// Arrange - Set up test data and conditions
// Act - Execute the code under test
// Assert - Verify the expected outcome
```

Keep tests focused: one behavior per test.

## Behavioral Tests vs Structural Tests (CRITICAL)

Write **behavioral tests** that verify WHAT the system does, not HOW it does it internally. This is essential for TDD because the REFACTOR phase changes internal structure -- structural tests break on every refactoring even when behavior is preserved.

**Behavioral test** (survives refactoring):
- Tests input/output contracts through public boundaries (UI, HTTP API, CLI, library exports)
- Breaks only when actual behavior changes

**Structural test** (breaks on refactoring):
- Tests call order, internal state, or implementation details
- Breaks when code is reorganized even if behavior is unchanged
- Forces simultaneous test+code changes, defeating the TDD safety net

**Red flags that a test is structural:**
- Asserts that method A calls method B
- Mocks internal dependencies to verify call patterns
- Test name describes HOW ("uses cache for repeated lookups") not WHAT ("returns same result for same input")
- Test breaks on refactor while behavior stays the same

**Rule:** If you feel the need to mock internal dependencies, step up to integration level instead. Reserve mocks for external services and non-deterministic behavior only.

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

### Prefer Integration Tests Over Excessive Mocking

Reserve mocks for external services and non-deterministic behavior. Prefer real dependencies where feasible.

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
