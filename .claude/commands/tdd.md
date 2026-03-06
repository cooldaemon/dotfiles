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
| Plan | `docs/plans/NNNN-{feature-name}/` (ux.md + how.md) |
| Code Review | `docs/code-reviews/*.md` |

## Git Policy
The tdd-guide agent manages its own git commits (semantic after GREEN, fixup after REFACTOR). Do NOT override this in the Task prompt.

## Auto-Review

After the tdd-guide subagent completes a US implementation successfully (plan mode or direct request -- NOT review fix mode), automatically execute the `/code-review` command's logic to launch all 6 parallel reviewers. If no issues are found, output: "US complete. Code review passed. Run `/tdd` for the next US or `/push-to-remote` when ready." If issues are found, a review report is written to `docs/code-reviews/`.

**IMPORTANT**: After the review report is presented, STOP and wait for the user's decision. Do NOT automatically start fixing issues. If the user wants fixes applied, re-run `/tdd` (it will detect the review report and fix pending issues).

## Next Commands
After TDD cycle with auto-review:
- `/tdd` - Fix review issues, or implement next US
- `/push-to-remote` - Autosquash fixups and push when ready
