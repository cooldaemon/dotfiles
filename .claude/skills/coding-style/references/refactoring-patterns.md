# Refactoring Patterns

Detailed examples for patterns referenced in coding-style SKILL.md.

## Extract Helper Functions

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

## Explaining Variables & Constants

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

## Chunk Statements

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

## Normalize Symmetries

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

## Dead Code Removal

Remove unused code aggressively:
- Unused functions, variables, and imports
- Commented-out code (git has history)
- Unreachable code paths
- Obsolete TODOs and FIXMEs

## One Pile

Consolidate related code:
- Move helper functions near their usage
- Group related constants together
- Combine scattered validation logic

## Separation of Concerns

- Separate business logic from presentation
- Keep I/O operations distinct from processing
- Isolate external dependencies
- Extract configuration from implementation

## Explicit Parameters

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
