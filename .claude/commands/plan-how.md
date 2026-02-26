---
description: "Create implementation plan with EARS system behavior using how-planner sub-agent"
---

I'll use the how-planner subagent to create an implementation plan (Phase 2: HOW).

The how-planner subagent will:
- Read the UX plan from `docs/plans/NNNN-{feature-name}/ux.md`
- Analyze requirements and architecture
- Define system behavior in EARS format per User Story
- Identify ADR candidates for non-trivial technical decisions
- Write to `docs/plans/NNNN-{feature-name}/how.md`

## Prerequisites
- UX plan exists at `docs/plans/NNNN-{feature-name}/ux.md` (created via `/plan-ux`)
- User has approved the UX plan

## Next Commands
After user approves how.md:
- `/create-architecture-decision` - Create ADRs for candidates listed in how.md (if any)
- `/tdd` - Implement with test-driven development
