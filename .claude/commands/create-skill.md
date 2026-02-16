---
description: "Create or update a Claude Code skill using a subagent"
---

I'll use the skill-creator subagent to create or update a skill.

The skill-creator subagent will:
- Follow skill-development guidelines
- Create proper folder structure and SKILL.md (for new skills)
- Apply minimal changes while ensuring compliance (for updates)
- Verify library-specific content with context7
- Apply the checklist before completion

## Prerequisites
- Clear understanding of what knowledge the skill should provide
- Optional: Implementation plan from `/plan`

## Next Commands
After creating/updating:
- `/git-commit` - Commit the skill changes
