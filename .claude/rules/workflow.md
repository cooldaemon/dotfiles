# Workflow Rules

## Task Routing

When the user requests a change, route to the correct starting command instead of using `EnterPlanMode`:

| Task Type | Entry Command | When |
|-----------|---------------|------|
| Code changes | `/plan-ux` | Application code, tests, infrastructure |
| Config changes | `/plan-claude-config` | `.claude/` files (agents, skills, commands, rules, hooks) |
| Bug investigation | `/investigate` | Bug reports, unexpected behavior |

Exception: trivial single-line fixes (typos, version bumps) can skip the planning workflow.

## One Plan, One Concern

Each plan addresses a single independent concern. When the user requests multiple unrelated changes in one message, split them into separate plan invocations. Two changes are "independent" if they can be approved, rejected, or implemented without affecting each other.
