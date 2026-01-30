---
description: "Run comprehensive code review with multiple specialized reviewers in parallel"
---

# Code Review

Run multiple specialized reviewers in parallel for comprehensive code analysis.

## Reviewers

| Reviewer | Focus |
|----------|-------|
| **code-reviewer** | Quality, readability, performance |
| **security-reviewer** | Security vulnerabilities, OWASP Top 10 |
| **database-reviewer** | SQL queries, ORM usage, schema design |

All three reviewers run **always** - ORM code changes affect generated SQL.

## Execution

1. **Detect changed files**: Run `git diff --name-only HEAD`
2. **Launch all reviewers in parallel** using Task tool
3. **Aggregate results**: Combine outputs into unified report

## Output Format

```markdown
# Code Review Report

## Summary
- Files Reviewed: X
- Total Issues: Y

## Code Review (code-reviewer)
[Results]

## Security Review (security-reviewer)
[Results]

## Database Review (database-reviewer)
[Results]

## Final Verdict
- ✅ APPROVE: No CRITICAL or HIGH issues
- ⚠️ APPROVE WITH WARNINGS: Only MEDIUM issues
- ❌ REQUEST CHANGES: CRITICAL or HIGH issues found
```

## Important

- All reviewers run in **parallel** for efficiency
- Reviewers **do not modify code** - they only report issues

## Next Commands

After review:
- `/tdd` - Fix issues with test-first approach
- `/e2e` - Run full E2E suite (if changes affect E2E-relevant code)
- `/git-commit` - Commit if approved
