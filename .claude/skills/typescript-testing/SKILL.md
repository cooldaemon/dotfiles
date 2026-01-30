---
name: typescript-testing
description: Jest and Vitest testing patterns for TypeScript and JavaScript projects.
---

# TypeScript/JavaScript Testing Patterns

Testing patterns using Jest or Vitest.

## Test Structure

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
      expect(user.name).toBe('Alice')
    })

    it('throws error for invalid email', async () => {
      const input = { name: 'Alice', email: 'invalid' }

      await expect(userService.createUser(input))
        .rejects.toThrow('Invalid email')
    })
  })
})
```

## Common Matchers

```typescript
// Equality
expect(value).toBe(exact)           // ===
expect(value).toEqual(deepEqual)    // Deep equality
expect(value).toStrictEqual(obj)    // Deep + type

// Truthiness
expect(value).toBeTruthy()
expect(value).toBeFalsy()
expect(value).toBeNull()
expect(value).toBeDefined()

// Numbers
expect(value).toBeGreaterThan(3)
expect(value).toBeLessThanOrEqual(5)
expect(value).toBeCloseTo(0.3, 5)   // Floating point

// Strings
expect(str).toMatch(/pattern/)
expect(str).toContain('substring')

// Arrays
expect(arr).toContain(item)
expect(arr).toHaveLength(3)
expect(arr).toEqual(expect.arrayContaining([1, 2]))

// Objects
expect(obj).toHaveProperty('key')
expect(obj).toMatchObject({ partial: 'match' })

// Exceptions
expect(() => fn()).toThrow()
expect(() => fn()).toThrow('message')
await expect(asyncFn()).rejects.toThrow()
```

## Mocking

### Function Mocks
```typescript
const mockFn = jest.fn()              // Vitest: vi.fn()
mockFn.mockReturnValue(42)
mockFn.mockResolvedValue({ data: [] })
mockFn.mockRejectedValue(new Error())

// Assertions
expect(mockFn).toHaveBeenCalled()
expect(mockFn).toHaveBeenCalledWith('arg1', 'arg2')
expect(mockFn).toHaveBeenCalledTimes(2)
```

### Module Mocks
```typescript
// Jest
jest.mock('./userRepository', () => ({
  findUser: jest.fn().mockResolvedValue({ id: '1', name: 'Alice' })
}))

// Vitest
vi.mock('./userRepository', () => ({
  findUser: vi.fn().mockResolvedValue({ id: '1', name: 'Alice' })
}))
```

### Spy
```typescript
const spy = jest.spyOn(object, 'method')  // Vitest: vi.spyOn
spy.mockImplementation(() => 'mocked')

// Restore original
spy.mockRestore()
```

## Setup and Teardown

```typescript
describe('Database tests', () => {
  beforeAll(async () => {
    await db.connect()
  })

  afterAll(async () => {
    await db.disconnect()
  })

  beforeEach(async () => {
    await db.clear()
  })

  afterEach(() => {
    jest.clearAllMocks()  // Vitest: vi.clearAllMocks()
  })
})
```

## Async Testing

```typescript
// Async/await
it('fetches data', async () => {
  const data = await fetchData()
  expect(data).toBeDefined()
})

// Resolves/Rejects
it('resolves with data', async () => {
  await expect(fetchData()).resolves.toEqual({ id: 1 })
})

it('rejects with error', async () => {
  await expect(fetchData()).rejects.toThrow('Network error')
})
```

## Test Coverage

```bash
# Jest
jest --coverage

# Vitest
vitest --coverage
```

```json
// jest.config.js or vitest.config.ts
{
  "coverageThreshold": {
    "global": {
      "branches": 80,
      "functions": 80,
      "lines": 80
    }
  }
}
```
