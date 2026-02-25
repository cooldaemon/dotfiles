---
description: "Create implementation plan with EARS system behavior and ADRs using planner sub-agent"
---

I'll use the planner subagent to create an implementation plan (Phase 2: HOW).

The planner subagent will:
- Read the UX plan from `docs/plans/{feature-name}/ux.md`
- Analyze requirements and architecture
- Define system behavior in EARS format per User Story
- Write ADRs for non-trivial technical decisions
- Write to `docs/plans/{feature-name}/how.md`

## Prerequisites
- UX plan exists at `docs/plans/{feature-name}/ux.md` (created via `/plan-ux`)
- User has approved the UX plan

## Next Commands
After user approves how.md:
- `/tdd` - Implement with test-driven development
