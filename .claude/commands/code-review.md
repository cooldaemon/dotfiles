---
description: "Run comprehensive code review with multiple specialized reviewers in parallel"
---

# Code Review

Run multiple specialized reviewers in parallel for comprehensive code analysis.

## Reviewers

| Reviewer | Focus |
|----------|-------|
| **code-reviewer** | Integrity, readability, comments, best practices |
| **security-reviewer** | Security vulnerabilities, OWASP Top 10 |
| **performance-reviewer** | Algorithmic complexity, memory, rendering, bundle size, caching, network optimization |
| **sre-reviewer** | Observability, resilience, health checks, resource limits |
| **database-reviewer** | SQL queries, ORM usage, schema design |
| **dead-code-reviewer** | Unused code, imports, dependencies |

All six reviewers run **always** - ORM code changes affect generated SQL, any code change can have performance or operational implications.

## Execution

1. **Detect changed files**: Run `git diff --name-only HEAD`
2. **Launch all reviewers in parallel** using Task tool
3. **Aggregate results**: Combine outputs into unified report
4. **Persist report**: Write to `docs/code-reviews/YYYY-MM-DD-HHMMSS.md`

## Report Persistence

### Directory Setup
Create `docs/code-reviews/` directory if it doesn't exist.

### File Output
After aggregating all reviewer outputs, write the full report to:
```
docs/code-reviews/YYYY-MM-DD-HHMMSS.md
```

Example: `docs/code-reviews/2026-02-12-143052.md`

### Report Format

```markdown
---
created: YYYY-MM-DD HH:MM:SS
status: PENDING
verdict: APPROVE | APPROVE_WITH_WARNINGS | REQUEST_CHANGES
files_reviewed: N
total_issues: N
---

# Code Review Report

## Summary
- **Files Reviewed:** N
- **Total Issues:** N (Critical: X, High: Y, Medium: Z)
- **Verdict:** APPROVE | APPROVE WITH WARNINGS | REQUEST CHANGES
- **Status:** PENDING

## Issues

### Critical
- [ ] [CR-001] Issue description - `file:line`
- [ ] [SR-001] Issue description - `file:line`

### High
- [ ] [CR-002] Issue description - `file:line`

### Medium
- [ ] [DR-001] Issue description - `file:line`

## Code Review (code-reviewer)
[Full output from code-reviewer agent]

## Security Review (security-reviewer)
[Full output from security-reviewer agent]

## Performance Review (performance-reviewer)
[Full output from performance-reviewer agent]

## SRE Review (sre-reviewer)
[Full output from sre-reviewer agent]

## Database Review (database-reviewer)
[Full output from database-reviewer agent]

## Dead Code Review (dead-code-reviewer)
[Full output from dead-code-reviewer agent]

## Resolution Log
| Issue ID | Resolved | Commit | Notes |
|----------|----------|--------|-------|
```

### Issue ID Prefixes
- `CR-NNN`: Code review issues
- `SR-NNN`: Security review issues
- `PR-NNN`: Performance review issues
- `SRE-NNN`: SRE review issues
- `DR-NNN`: Database review issues
- `DC-NNN`: Dead code issues

### Zero Issues Case
If no issues are found, do NOT create a report file. Simply display "No issues found" in the conversation.

## Important

- All reviewers run in **parallel** for efficiency
- Reviewers **do not modify code** - they only report issues
- Report file enables `/tdd` to systematically address issues

## Next Commands

After review:
- `/tdd` - Fix issues with test-first approach (creates fixup commits)
- `/e2e` - Run full E2E suite (if changes affect E2E-relevant code)
- `/push-to-remote` - Autosquash fixups and push when ready

> **Note:** `/tdd` auto-runs code review after each US. Use `/code-review` standalone only for re-review or manual scenarios.
