---
name: coding-style
description: Coding style principles including immutability, guard clauses, and single responsibility. Use when writing, reviewing, or refactoring source code.
---

# Coding Style

## Core Principles

- **KISS** (Keep It Simple) - Simplest solution that works
- **DRY** (Don't Repeat Yourself) - Extract common logic into functions
- **YAGNI** (You Aren't Gonna Need It) - Don't build features before needed

## Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate:

```javascript
// WRONG: Mutation
function updateUser(user, name) {
  user.name = name  // MUTATION!
  return user
}

// CORRECT: Immutability
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

## Data + Functions over Classes

Prefer simple data structures with pure functions over classes:

```python
# WRONG: Unnecessary class
class Order:
    def __init__(self, items):
        self.items = items
        self.discount = 0

    def set_discount(self, rate):
        self.discount = rate

    def calculate_total(self):
        subtotal = sum(item['price'] * item['qty'] for item in self.items)
        return subtotal * (1 - self.discount)

# CORRECT: Data structure + functions
@dataclass(frozen=True)
class Order:
    items: list[dict]
    discount: float = 0.0

def calculate_subtotal(order: Order) -> float:
    return sum(item['price'] * item['qty'] for item in order.items)

def calculate_total(order: Order) -> float:
    return calculate_subtotal(order) * (1 - order.discount)

def apply_discount(order: Order, rate: float) -> Order:
    return Order(items=order.items, discount=rate)
```

### When Classes ARE Justified

- Polymorphism is genuinely needed (multiple implementations of same interface)
- Framework requires it (Django models, React components)
- Complex state machine with invariants that must be enforced

### Prefer for Data

- Python: `dataclass(frozen=True)`, `NamedTuple`, `TypedDict`
- TypeScript: `interface`, `type`
- Go: `struct`

## Guard Clauses (Early Returns)

Convert nested conditionals to early returns:

```javascript
// WRONG: Deep nesting
function process(data) {
  if (data) {
    if (data.isValid) {
      if (data.items.length > 0) {
        return processItems(data.items);
      }
    }
  }
  return null;
}

// CORRECT: Guard clauses
function process(data) {
  if (!data) return null;
  if (!data.isValid) return null;
  if (data.items.length === 0) return null;

  return processItems(data.items);
}
```

## Single Responsibility

Each function should do one thing well:

```python
# WRONG: Multiple responsibilities
def process_and_save_user(data):
    # Validation, processing, saving, notification all in one
    ...

# CORRECT: Single responsibility
def validate_user_data(data): ...
def create_user_from_data(data): ...
def save_user(user): ...
def notify_user_creation(user): ...

def process_and_save_user(data):
    validate_user_data(data)
    user = create_user_from_data(data)
    save_user(user)
    notify_user_creation(user)
    return user
```

## Self-Documenting Code

Write code that doesn't need comments:

```python
# WRONG: Needs comments to understand
def calc(x, y, t):
    # Calculate compound interest
    # x is principal, y is rate, t is time
    return x * (1 + y) ** t

# CORRECT: Self-documenting
def calculate_compound_interest(principal, annual_rate, years):
    return principal * (1 + annual_rate) ** years
```

## Build Automation (Makefile)

**ALWAYS use Makefile** - Never run commands directly:

```makefile
# CORRECT: Makefile as interface and documentation
.PHONY: build test lint check

build:
	npm run build

test:
	npm run test -- --coverage

lint:
	npm run lint

check: lint test build  ## Run all checks before PR
```

**Why Makefile:**
- Single entry point for all operations
- Self-documenting (serves as handover documentation)
- Language-agnostic interface
- Enables `make check` before every PR

**Anti-pattern:** Running raw commands (`npm run build`, `go test ./...`) directly.

## File Organization

MANY SMALL FILES > FEW LARGE FILES:
- High cohesion, low coupling
- 200-400 lines typical, 800 max
- Extract utilities from large components
- Organize by feature/domain, not by type

## Error Handling

### Principle: Consistency Over Preference

Error handling paradigms vary by language and framework:

| Paradigm | Languages/Frameworks |
|----------|---------------------|
| try/catch (Exceptions) | JavaScript, Python, Java, C# |
| Result/Option types | Rust, Swift, Kotlin |
| Either monad | Haskell, Scala, fp-ts |
| Error return + defer | Go |
| Error return values | C |

**The worst anti-pattern is mixing paradigms in one project.**

### Rules

1. **Follow the project's existing convention** - Don't introduce a new paradigm
2. **Follow the language/framework idiom** - Go uses error returns + defer, Rust uses Result
3. **Be consistent** - If project uses try/catch, use try/catch everywhere
4. **Convert at boundaries** - When a library uses a different paradigm, wrap/convert errors at the integration point to match your project's style
5. **Handle errors at appropriate levels** - Don't catch and ignore

### Before Writing Error Handling, Check:
- What paradigm does this project already use?
- What is idiomatic for this language/framework?
- Does the library return errors differently? → Convert at boundary
- Am I maintaining consistency with existing code?

## Input Validation

ALWAYS validate user input:

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

const validated = schema.parse(input)
```

## Logging (Server-Side)

ALWAYS use structured logging on server-side code:
- Use machine-parseable format (JSON, logfmt, etc.)
- Include: timestamp, level, message, requestId
- Never log sensitive data (passwords, tokens, PII)

## Code Quality Checklist

Before marking work complete:
- [ ] Code is readable and well-named
- [ ] Functions are small (<50 lines)
- [ ] Files are focused (<800 lines)
- [ ] No deep nesting (>4 levels)
- [ ] Guard clauses used for early returns
- [ ] Single responsibility per function
- [ ] Data + functions preferred over classes
- [ ] Proper error handling
- [ ] No console.log statements
- [ ] No hardcoded values
- [ ] No mutation (immutable patterns used)

## Refactoring

For detailed refactoring patterns (Extract Helper, Chunk Statements, Normalize Symmetries, etc.), use `/refactor-code` command.
