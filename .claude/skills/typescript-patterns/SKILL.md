---
name: typescript-patterns
description: TypeScript and JavaScript development patterns for Node.js and general backend/tooling development.
---

# TypeScript/JavaScript Patterns

Patterns for TypeScript and JavaScript development (Node.js, tooling).

## Naming Conventions

### Variables
```typescript
// Descriptive names
const marketSearchQuery = 'election'
const isUserAuthenticated = true
const totalRevenue = 1000

// Avoid: unclear names
const q = 'election'
const flag = true
```

### Functions
```typescript
// Verb-noun pattern
async function fetchMarketData(marketId: string) { }
function calculateSimilarity(a: number[], b: number[]) { }
function isValidEmail(email: string): boolean { }
```

## Async/Await Patterns

### Parallel Execution
```typescript
// GOOD: Parallel when independent
const [users, markets, stats] = await Promise.all([
  fetchUsers(),
  fetchMarkets(),
  fetchStats()
])

// BAD: Sequential when unnecessary
const users = await fetchUsers()
const markets = await fetchMarkets()
const stats = await fetchStats()
```

### Error Handling
```typescript
async function fetchData(url: string) {
  try {
    const response = await fetch(url)
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }
    return await response.json()
  } catch (error) {
    console.error('Fetch failed:', error)
    throw new Error('Failed to fetch data')
  }
}
```

## Type Safety

```typescript
// GOOD: Proper types with union for status
interface Market {
  id: string
  name: string
  status: 'active' | 'resolved' | 'closed'
  created_at: Date
}

function getMarket(id: string): Promise<Market> { }

// BAD: Using 'any'
function getMarket(id: any): Promise<any> { }
```

## Module Organization

```
src/
├── index.ts           # Entry point
├── types/             # TypeScript types
├── lib/               # Utilities and helpers
├── services/          # Business logic
└── handlers/          # Request handlers
```
