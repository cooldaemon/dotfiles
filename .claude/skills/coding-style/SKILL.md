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

### Comment Anti-Patterns

**Forbidden: Arbitrary ID prefixes**
```python
# WRONG
# SR-001: Check if path exists
# CR-042: Handle edge case

# CORRECT: No IDs in code comments
# IDs belong in issue trackers, not code
```

**Forbidden: Comments explaining WHAT**
```python
# WRONG: Comment should be a function name
# Validate cwd is a valid directory
project_root = Path(cwd).resolve()

# CORRECT: Function name explains WHAT
project_root = resolve_project_root(cwd)
```

**Allowed: Comments explaining WHY**
```python
# Skip validation for admin users per SEC-2024 audit requirement
# Using setTimeout due to React 18 batching bug (fixed in 18.3)
# See RFC 7231 section 6.5.4 for 404 semantics
```

## Refactoring Patterns

Apply these patterns during TDD REFACTOR phase to improve code quality.

### Extract Helper Functions

Break complex logic into well-named helpers:

```python
# BEFORE
def calculate_price(items):
    total = sum(item.price * item.quantity for item in items)
    tax = total * 0.08 if total > 100 else total * 0.05
    shipping = 10 if total < 50 else 0
    return total + tax + shipping

# AFTER
def calculate_price(items):
    subtotal = calculate_subtotal(items)
    tax = calculate_tax(subtotal)
    shipping = calculate_shipping(subtotal)
    return subtotal + tax + shipping

def calculate_subtotal(items):
    return sum(item.price * item.quantity for item in items)

def calculate_tax(subtotal):
    return subtotal * 0.08 if subtotal > 100 else subtotal * 0.05

def calculate_shipping(subtotal):
    return 10 if subtotal < 50 else 0
```

### Explaining Variables & Constants

Replace magic values and complex expressions with named variables/constants:

```javascript
// BEFORE
if (user.age >= 18 && user.age <= 65 && user.credits > 1000) {
  applyDiscount(order.total * 0.15);
}

// AFTER
const MINIMUM_AGE = 18;
const MAXIMUM_AGE = 65;
const MINIMUM_CREDITS = 1000;
const DISCOUNT_RATE = 0.15;

const isEligibleAge = user.age >= MINIMUM_AGE && user.age <= MAXIMUM_AGE;
const hasEnoughCredits = user.credits > MINIMUM_CREDITS;
const isEligibleForDiscount = isEligibleAge && hasEnoughCredits;

if (isEligibleForDiscount) {
  const discountAmount = order.total * DISCOUNT_RATE;
  applyDiscount(discountAmount);
}
```

### Chunk Statements

Group related code with blank lines:

```python
# BEFORE
user = get_user(user_id)
validate_user(user)
order = create_order()
order.user = user
items = get_cart_items(user)
for item in items:
    order.add_item(item)
calculate_totals(order)
save_order(order)

# AFTER
user = get_user(user_id)
validate_user(user)

order = create_order()
order.user = user

items = get_cart_items(user)
for item in items:
    order.add_item(item)

calculate_totals(order)
save_order(order)
```

### Normalize Symmetries

Make similar code look similar:

```javascript
// BEFORE
if (type === 'admin') {
  user.role = 'administrator';
  user.permissions = getAllPermissions();
} else if (type === 'mod') {
  user.permissions = getModeratorPermissions();
  user.role = 'moderator';  // Different order!
}

// AFTER
if (type === 'admin') {
  user.role = 'administrator';
  user.permissions = getAllPermissions();
} else if (type === 'mod') {
  user.role = 'moderator';
  user.permissions = getModeratorPermissions();
}
```

### Dead Code Removal

Remove unused code aggressively:
- Unused functions, variables, and imports
- Commented-out code (git has history)
- Unreachable code paths
- Obsolete TODOs and FIXMEs

### One Pile

Consolidate related code:
- Move helper functions near their usage
- Group related constants together
- Combine scattered validation logic

### Separation of Concerns

- Separate business logic from presentation
- Keep I/O operations distinct from processing
- Isolate external dependencies
- Extract configuration from implementation

### Explicit Parameters

Make dependencies clear:

```javascript
// BEFORE (hidden dependencies)
function calculateTotal() {
  const items = globalCart.items;  // Hidden global
  const taxRate = config.taxRate;  // Hidden config
  return items.reduce((sum, item) => sum + item.price, 0) * (1 + taxRate);
}

// AFTER (explicit parameters)
function calculateTotal(items, taxRate) {
  return items.reduce((sum, item) => sum + item.price, 0) * (1 + taxRate);
}
```

## Refactoring Safety Rules

1. **Maintain Functionality** - Never break existing behavior
2. **Small Steps** - Apply changes incrementally
3. **Test After Each Change** - Ensure tests pass after each refactoring
4. **Stage Large Changes** - Work in reviewable chunks
5. **Version Control** - Commit after each successful refactoring
6. **Preserve Tests** - Never delete tests without understanding their purpose
7. **Document Breaking Changes** - If API changes are necessary, document them

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
- [ ] No comments with arbitrary IDs (SR-001, CR-042, etc.)
- [ ] Comments explain WHY, not WHAT

