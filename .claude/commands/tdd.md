---
description: "Enforce test-driven development workflow using a subagent"
---

I'll use the tdd-guide subagent to enforce test-driven development methodology.

## Usage

```
/tdd                      # Full TDD cycle or fix ALL review issues
/tdd CR-001 CR-003        # Fix only specific review issues
/tdd [free-text request]  # Direct TDD request without plan
```

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

## Git Policy
The tdd-guide agent manages its own git commits (semantic after GREEN, fixup after REFACTOR). Do NOT override this in the Task prompt.

## Next Commands
After TDD cycle:
- `/code-review` - Review the changes
- `/tdd` - Fix review issues or implement next US
- `/push-to-remote` - Autosquash fixups and push when ready
