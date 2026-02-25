---
description: "Create implementation plan for Claude Code configuration changes using claude-config-planner sub-agent"
---

I'll use the claude-config-planner subagent to create a configuration change plan.

The claude-config-planner subagent will:
- Gather requirements from user (asks clarifying questions if ambiguous)
- Analyze existing .claude/ structure for consistency
- Check for duplication/conflicts between skills, agents, rules
- Create plan with task list
- Write to `docs/plans/NNNN-feature-name.md`

## Prerequisites
- Clear understanding of the configuration change needed
- Access to .claude/ directory structure

## Next Commands
After user approves the plan:
- `/update-claude-config` - Execute the plan
