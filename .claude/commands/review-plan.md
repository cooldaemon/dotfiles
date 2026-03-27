---
description: "Critically review plans for unstated assumptions, engineering calibration, and cross-plan coherence"
---

I'll launch the plan-reviewer to review the current plan.

The plan-reviewer will:
- Find the most recent plan in `docs/plans/`
- Review for unstated assumptions, engineering calibration (over/under-engineering)
- Check cross-plan coherence (ux.md vs how.md vs ADRs)
- Evaluate scope proportionality
- Report findings with severity levels

**IMPORTANT**: After the review is presented, STOP and wait for the user's decision. Do NOT automatically modify any files.

## Prerequisites
- A plan exists in `docs/plans/` (from `/plan-ux`, `/plan-how`, or `/plan-claude-config`)

## Next Commands

After the review is presented, suggest the appropriate next command based on the current workflow context:

| Called after | Next command |
|-------------|-------------|
| `/plan-ux` | `/plan-how` - Create implementation plan |
| `/plan-how` | `/tdd` - Implement with test-driven development |
| `/plan-claude-config` | `/update-claude-config` - Execute the plan |

If issues were found, suggest addressing them first, then re-running `/review-plan`.

Always show the suggested next command explicitly so the user knows where they are in the workflow.
