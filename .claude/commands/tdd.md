---
description: "Enforce test-driven development workflow using a subagent"
---

I'll use the tdd-guide subagent to enforce test-driven development methodology.

## Prerequisites
- For large tasks: Run `/plan` first to get EARS acceptance criteria
- For small tasks: Describe the requirement directly
- Test framework configured in the project

## Context Sources

The tdd-guide agent automatically checks for context:

| Source | Location |
|--------|----------|
| Plan | `docs/plans/*.md` |
| Code Review | `docs/code-reviews/*.md` |

## Next Commands
After TDD cycle:
- `/code-review` - Review the implementation
- `/git-commit` - Commit the changes
