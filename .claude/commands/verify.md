---
description: "Run verification checks (build, type, lint, unit/integration tests) - excludes E2E"
---

Run verification on current codebase state (excludes E2E tests for speed).

Refer to `verification-loop` and `coding-style` skills for execution details.

For E2E tests, use `/e2e` command separately.

## Output Format

```
VERIFICATION: [PASS/FAIL]

Build:    [OK/FAIL]
Types:    [OK/X errors]
Lint:     [OK/X issues]
Tests:    [X/Y passed]

Ready for PR: [YES/NO]
```

## Next Commands
After verification:
- `/code-review` - If verification passes
- `/tdd` - If tests need fixing
