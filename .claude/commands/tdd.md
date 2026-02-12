---
description: "Enforce test-driven development workflow using a subagent"
---

I'll use the tdd-guide subagent to enforce test-driven development methodology.

## Prerequisites
- For large tasks: Run `/plan` first to get EARS acceptance criteria
- For small tasks: Describe the requirement directly
- Test framework configured in the project

## Context Sources (Check on Startup)

TDD can use two context sources. Check both on startup:

| Source | Location | Purpose |
|--------|----------|---------|
| **Plan** | `docs/plans/*.md` | EARS acceptance criteria for new features |
| **Code Review** | `docs/code-reviews/*.md` | Issues to fix from code review |

### Priority
1. If **both** exist: Address code review issues first, then implement plan
2. If **only plan** exists: Implement according to EARS criteria
3. If **only code review** exists: Fix issues systematically
4. If **neither** exists: Proceed with user's direct request

## Plan Integration

### Check for Existing Plans
```bash
ls -la docs/plans/*.md 2>/dev/null
```

### If Plan Exists
1. Read the plan file
2. Extract EARS acceptance criteria
3. Convert to Gherkin scenarios for TDD
4. Delete plan file when implementation is complete (use `/plan-done`)

## Code Review Report Integration

### Check for Existing Reports
Before starting TDD, check if a code review report exists in `docs/code-reviews/`:

```bash
ls -la docs/code-reviews/*.md 2>/dev/null
```

### If Report Exists
1. Read the latest report (most recent by filename)
2. Display pending issues (unchecked `- [ ]` items)
3. Offer to address issues systematically
4. As issues are fixed, mark them complete (`- [x]`)
5. Update report status to `IN_PROGRESS` while working

### On Completion
When all issues in the report are resolved:
1. Update report status to `RESOLVED`
2. Delete the report file
3. Display confirmation: "Code review report resolved and deleted: [filename]"

## Next Commands
After TDD cycle:
- `/code-review` - Review the implementation
- `/git-commit` - Commit the changes
