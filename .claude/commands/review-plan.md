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
After review:
- Address findings, then re-run `/review-plan` to verify
- `/tdd` - Proceed to implementation if review passes
- `/update-claude-config` - Proceed if this is a config plan
