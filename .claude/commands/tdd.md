---
description: "Enforce test-driven development workflow using a subagent"
---

I'll use the tdd-guide subagent to enforce test-driven development methodology.

## Prerequisites
- For large tasks: Run `/plan-ux` then `/plan-how` first to get Gherkin scenarios and EARS system behavior
- For small tasks: Describe the requirement directly
- Test framework configured in the project

## Context Sources

The tdd-guide agent automatically checks for context:

| Source | Location |
|--------|----------|
| Plan | `docs/plans/{feature-name}/` (ux.md + how.md) |
| Code Review | `docs/code-reviews/*.md` |

## Next Commands
After TDD cycle (tdd-guide handles commits internally):
- `/code-review` - Review the changes
- `/tdd` - Fix review issues or implement next US
- `/push-to-remote` - Autosquash fixups and push when ready
