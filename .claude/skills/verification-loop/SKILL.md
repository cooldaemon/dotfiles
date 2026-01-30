---
name: verification-loop
description: Pre-PR verification checklist. Use after completing features, before creating PRs, or after refactoring.
---

# Verification Loop

## When to Use

- After completing a feature or significant code change
- Before creating a PR
- After refactoring

## Verification Phases

### Phase 1: Build
```bash
# Check if project builds
npm run build    # Node.js
go build ./...   # Go
cargo build      # Rust
```
If build fails, STOP and fix before continuing.

### Phase 2: Type Check
```bash
# TypeScript
npx tsc --noEmit

# Python
pyright .
mypy .

# Go (built into compiler)
go vet ./...
```

### Phase 3: Lint
```bash
# TypeScript/JavaScript
npm run lint

# Python
ruff check .

# Go
golangci-lint run
```

### Phase 4: Test Suite
```bash
# Run tests with coverage
npm run test -- --coverage
go test -cover ./...
pytest --cov
```

### Phase 5: Security Scan
```bash
# Secrets detection
gitleaks detect --source .

# Dependency vulnerabilities
npm audit
pip-audit
```

### Phase 6: Diff Review
```bash
git diff --stat
git diff HEAD~1 --name-only
```

Review each changed file for:
- Unintended changes
- Missing error handling
- Potential edge cases

## Output Format

```
VERIFICATION REPORT
==================
Build:     [PASS/FAIL]
Types:     [PASS/FAIL] (X errors)
Lint:      [PASS/FAIL] (X warnings)
Tests:     [PASS/FAIL] (X/Y passed, Z% coverage)
Security:  [PASS/FAIL] (X issues)
Diff:      [X files changed]

Overall:   [READY/NOT READY] for PR

Issues to Fix:
1. ...
```

## Checklist

- [ ] Build passes
- [ ] No type errors
- [ ] No lint errors (warnings reviewed)
- [ ] All tests pass
- [ ] Coverage meets threshold
- [ ] No security issues
- [ ] Diff reviewed for unintended changes
