# Workflow Rules

## Task Routing

When the user requests a change, route to the correct starting command instead of using `EnterPlanMode`:

| Task Type | Entry Command | When |
|-----------|---------------|------|
| Code changes | `/plan-ux` | Application code, tests, infrastructure |
| Config changes | `/plan-claude-config` | `.claude/` files (agents, skills, commands, rules, hooks) |
| Bug investigation | `/investigate` | Bug reports, unexpected behavior |

Exception: trivial single-line fixes (typos, version bumps) can skip the planning workflow.
