# Example Update Scenarios

## Scenario 1: New Testing Approach

```markdown
## Testing

### Unit Tests
- Framework: Jest with React Testing Library
- Run tests: `npm test`
- Watch mode: `npm test -- --watch`
- Coverage: `npm test -- --coverage`

**Important**: Mock API calls using MSW (Mock Service Worker) for consistent test behavior.
```

## Scenario 2: Discovered Gotcha

```markdown
## Important Notes

### Gotchas
- **Database Connections**: Always use connection pooling. Direct connections cause "too many connections" errors in production.
- **File Uploads**: Multipart form data must include `boundary` parameter. Use FormData API, not manual construction.
```

## Scenario 3: New Build Process

```markdown
## Commands

### Build
```bash
# Development build with hot reload
npm run dev

# Production build (optimized)
npm run build

# Build and analyze bundle size
npm run build:analyze
```
```

## Scenario 4: Monorepo Package-Specific Notes

**Root CLAUDE.md:**
```markdown
# CLAUDE.md

## Project Overview
This is a monorepo with API and Frontend packages.

## Common Commands
- `npm run build:all` - Build all packages
- `npm run test:all` - Test all packages
```

**packages/api/CLAUDE.md:**
```markdown
# API Package

## API-Specific Commands
- `npm run migrate` - Run database migrations
- `npm run seed` - Seed test data

## Gotchas
- Always run migrations before tests
```
