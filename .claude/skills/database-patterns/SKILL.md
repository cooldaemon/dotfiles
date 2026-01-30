---
name: database-patterns
description: Database patterns including MySQL/Aurora optimization, index design, caching principles, and NoSQL guidelines. Use when working with databases, writing SQL, creating migrations, or designing schemas.
---

# Database Patterns

Database design and optimization patterns for MySQL/Aurora with caching and NoSQL guidelines.

## Core Principles

### 1. Transaction and Data Consistency First

The primary reason to use RDBMS is data consistency through transactions.
Prioritize designs that maximize ACID properties.

### 2. Avoid Distributed Transactions (2PC)

Two-Phase Commit is complex and increases deadlock risk.

- **Horizontal Sharding**: Design so transactions complete within a single DB
- **Vertical Partitioning**: Avoid if possible (requires 2PC)

### 3. Sharding ID Strategy

For horizontal sharding, use **UUID v4**:
- AUTO_INCREMENT can conflict in distributed environments
- UUID v4 is unpredictable and distributes evenly

### 4. External Store Consistency

**Principle: RDBMS Must Work Without Cache**

RDBMS should function correctly even without Redis/Memcached cache.

**Caching is Often a Bad Habit:**
- ❌ Caching hides poor query design and missing indexes
- ❌ Caching breaks data consistency (stale data, race conditions)
- ❌ Caching adds complexity (invalidation is hard)
- ❌ Caching delays proper MySQL tuning

**Before Adding Cache, Ask:**
1. Have you analyzed slow queries with EXPLAIN?
2. Have you added proper indexes?
3. Have you optimized schema design?
4. Have you considered connection pooling?
5. Have you tuned MySQL/Aurora parameters?

**Cache is Justified ONLY When:**
- All RDBMS optimizations are exhausted
- Read pattern is truly cache-friendly (same data, many reads)
- Inconsistency window is explicitly acceptable
- You have cache invalidation strategy documented

**MongoDB Usage Guidelines:**
- ✅ Read-only master data (no updates in production)
- ✅ Logs that don't require transactions
- ❌ Frequently updated data
- ❌ Data requiring consistency with RDBMS

**Eventual Consistency is Hard:**
Eventual consistency is more difficult than it appears.
Prefer RDBMS transactions for consistency whenever possible.

## Index Patterns

### Add Indexes on WHERE and JOIN Columns

```sql
CREATE TABLE orders (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_id BIGINT,
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  INDEX idx_customer_id (customer_id)
);
```

### Composite Indexes

```sql
-- Equality columns first, then range
CREATE INDEX idx_status_created ON orders (status, created_at);
```

**Leftmost Prefix Rule:**
- Index `(status, created_at)` works for:
  - `WHERE status = 'pending'`
  - `WHERE status = 'pending' AND created_at > '2024-01-01'`
- Does NOT work for:
  - `WHERE created_at > '2024-01-01'` alone

### Covering Indexes

```sql
CREATE INDEX idx_email_name ON users (email, name, created_at);
-- Query uses index-only scan
SELECT email, name FROM users WHERE email = 'user@example.com';
```

## Schema Design

### Data Type Selection

```sql
CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active TINYINT(1) DEFAULT 1,
  balance DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Key Points:**
- **BIGINT** for IDs (not INT)
- **DECIMAL** for money (not FLOAT/DOUBLE)
- **TIMESTAMP** for time
- **utf8mb4** charset (full Unicode)
- **InnoDB** engine (transactions, foreign keys)

### Naming Conventions

Use lowercase_snake_case for all identifiers.

## Query Optimization

### Eliminate N+1 Queries

```sql
-- BAD: N+1 pattern
SELECT id FROM users WHERE active = 1;
-- Then 100 separate queries...

-- GOOD: Single query with IN or JOIN
SELECT u.id, u.name, o.*
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE u.active = 1;
```

### Cursor-Based Pagination

```sql
-- BAD: OFFSET gets slower with depth
SELECT * FROM products ORDER BY id LIMIT 20 OFFSET 199980;

-- GOOD: Cursor-based (always fast)
SELECT * FROM products WHERE id > 199980 ORDER BY id LIMIT 20;
```

### Batch Operations

```sql
-- GOOD: Batch insert
INSERT INTO events (user_id, action) VALUES
  (1, 'click'),
  (2, 'view'),
  (3, 'click');
```

## Concurrency & Locking

### Keep Transactions Short

```sql
-- BAD: Lock held during external operation
START TRANSACTION;
SELECT * FROM orders WHERE id = 1 FOR UPDATE;
-- HTTP call takes 5 seconds...
UPDATE orders SET status = 'paid' WHERE id = 1;
COMMIT;

-- GOOD: Minimal lock duration
START TRANSACTION;
UPDATE orders SET status = 'paid', payment_id = ?
WHERE id = ? AND status = 'pending';
COMMIT;
```

### Prevent Deadlocks

Always lock rows in consistent order:

```sql
START TRANSACTION;
SELECT * FROM accounts WHERE id IN (1, 2) ORDER BY id FOR UPDATE;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

## Aurora Specific

### Read Replicas

- Use reader endpoint for read-heavy queries
- Use writer endpoint for writes only

### Connection Management

- Use connection pooling (RDS Proxy recommended)
- Keep transactions short for failover resilience
- Implement retry logic for failover scenarios

## Security

### Least Privilege

```sql
-- GOOD: Minimal permissions
CREATE USER 'app_readonly'@'%' IDENTIFIED BY 'password';
GRANT SELECT ON mydb.products TO 'app_readonly'@'%';

CREATE USER 'app_writer'@'%' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE ON mydb.orders TO 'app_writer'@'%';
-- No DELETE permission unless needed
```

## Anti-Patterns

### Design Anti-Patterns
- Vertical partitioning (requires 2PC)
- Cross-database transactions
- Data consistency dependent on cache
- Designs requiring RDBMS-NoSQL consistency

### Query Anti-Patterns
- `SELECT *` in production code
- Missing indexes on WHERE/JOIN columns
- OFFSET pagination on large tables
- N+1 query patterns

### Schema Anti-Patterns
- `INT` for IDs (use `BIGINT`)
- `FLOAT` for money (use `DECIMAL`)
- Missing `utf8mb4` charset

## Review Checklist

- [ ] Transactions complete within a single DB
- [ ] No 2PC required
- [ ] System works without cache
- [ ] All WHERE/JOIN columns indexed
- [ ] Composite indexes in correct column order
- [ ] Proper data types (BIGINT, DECIMAL, TIMESTAMP)
- [ ] utf8mb4 charset used
- [ ] No N+1 query patterns
- [ ] Transactions kept short

**Remember**: Data consistency is the top priority. Avoid distributed transactions and eventual consistency whenever possible.
