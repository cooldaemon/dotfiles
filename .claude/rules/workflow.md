# Workflow Rules

## Task Routing

When the user requests a change, route to the correct starting command instead of using `EnterPlanMode`:

| Task Type | Entry Command | When |
|-----------|---------------|------|
| Code changes | `/plan-ux` | Application code, tests, infrastructure |
| Config changes | `/plan-claude-config` | `.claude/` files (agents, skills, commands, rules, hooks) |
| Bug investigation | `/investigate` | Bug reports, unexpected behavior |

Full workflow sequences (including optional steps):
- Code: `/plan-ux` → `/review-plan` (optional) → `/explore` (optional) → `/plan-how` → `/review-plan` (optional) → `/tdd` or `/tdd-team` (experimental) → `/push-to-remote`

Exception: trivial single-line fixes (typos, version bumps) can skip the planning workflow.

## One Plan, One Concern

Each plan addresses a single independent concern. When the user requests multiple unrelated changes in one message, split them into separate plan invocations. Two changes are "independent" if they can be approved, rejected, or implemented without affecting each other.

## Optional Plan Review

After any `/plan-xxx` command completes, `/review-plan` can be used to check cross-cutting concerns (unstated assumptions, engineering calibration, cross-plan coherence, scope proportionality). This is independent of the PCOS domain critics that run during planning.

## Before New Features

Before routing a new feature request to `/plan-ux`:
- Verify the user need is explicit — ease of implementation is not justification
- Consider whether improving existing functionality already solves the need
