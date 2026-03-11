---
name: typescript-patterns
description: TypeScript and JavaScript development patterns including package manager detection (npm, pnpm, bun, yarn), project structure, and Node.js backend/tooling.
durability: encoded-preference
---

# TypeScript/JavaScript Patterns

Patterns for TypeScript and JavaScript development (Node.js, tooling).

## Package Manager Detection (CRITICAL)

**Before running ANY npm/package commands, detect the package manager:**

| File | Package Manager | Install | Run Script |
|------|-----------------|---------|------------|
| `bun.lockb` or `bun.lock` | bun | `bun install` | `bun run` |
| `pnpm-lock.yaml` | pnpm | `pnpm install` | `pnpm run` |
| `yarn.lock` | yarn | `yarn install` | `yarn` |
| `package-lock.json` | npm | `npm install` | `npm run` |
| None (new project) | npm | `npm init -y` | `npm run` |

**NEVER use `npm install` directly when a non-npm lock file exists.**

### New Project Setup

When scaffolding a new TypeScript project, always initialize with a package manager:

```bash
# Default (npm is always available with Node.js)
npm init -y && npx tsc --init

# If pnpm is available and preferred
pnpm init && pnpm add -D typescript && pnpm exec tsc --init

# If bun is available and preferred
bun init
```

**Follow the existing project's lock file. Never mix package managers.**

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
