---
description: "Run E2E tests using a subagent (full suite or specific test)"
---

I'll use the e2e-runner subagent to execute E2E tests.

## Usage

- `/e2e` - Run full E2E suite
- `/e2e path/to/test.feature` - Run specific test

## Prerequisites
- E2E framework configured (Playwright or Cypress)
- Application running or dev server configured

## Next Commands
After E2E tests:
- `/tdd` - Fix failing tests
- `/code-review` - Review if all tests pass
- `/git-commit` - Commit if approved
