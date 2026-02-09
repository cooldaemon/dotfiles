---
name: typescript-testing
description: Jest and Vitest testing policies for TypeScript/JavaScript. Use when writing or reviewing TS/JS tests.
---

# TypeScript/JavaScript Testing Policies

## Test Structure (AAA Pattern)

```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('creates user with valid input', async () => {
      // Arrange
      const input = { name: 'Alice', email: 'alice@example.com' }
      // Act
      const user = await userService.createUser(input)
      // Assert
      expect(user.id).toBeDefined()
    })
  })
})
```

## Mocking Policies

### Clear Mocks After Each Test

```typescript
afterEach(() => {
  jest.clearAllMocks()  // Vitest: vi.clearAllMocks()
})
```

### Prefer spyOn Over Full Mocks

```typescript
// GOOD: Spy on specific method
const spy = jest.spyOn(service, 'save')

// AVOID: Full module mock when not needed
jest.mock('./service')
```

### Restore Spies

```typescript
afterEach(() => {
  spy.mockRestore()
})
```

## Async Testing

```typescript
// Use async/await
it('fetches data', async () => {
  const data = await fetchData()
  expect(data).toBeDefined()
})

// Use rejects for error cases
await expect(fetchData()).rejects.toThrow('Network error')
```

## Coverage Targets

| Metric | Target |
|--------|--------|
| Lines | 80%+ |
| Branches | 80%+ |
| Functions | 80%+ |

## Commands

**See `makefile-first` skill** for command execution policy.

```bash
jest --coverage
vitest --coverage
```

## Anti-Patterns

| Anti-Pattern | Correct Approach |
|--------------|------------------|
| Testing implementation | Test behavior/output |
| Missing mock cleanup | Use `clearAllMocks()` in afterEach |
| Flaky async tests | Use proper async/await |
| Mock everything | Prefer integration tests |

## Best Practices

- Write tests FIRST (TDD)
- One assertion focus per test
- Clear test names describing behavior
- Use beforeEach/afterEach for setup/cleanup
