---
description: "Execute an implementation plan to update Claude Code configuration (commands, agents, skills, docs)"
---

I'll use the claude-config-updater subagent to execute the specified plan.

The claude-config-updater subagent will:
- Read the plan file and understand its phases
- Execute each phase in order (create, modify, delete files)
- Track progress by updating checkboxes in the plan
- Verify consistency after completion
- Handle skill creation following skill-development guidelines

## Usage

- `/update-claude-config 0001` - Execute plan by number
- `/update-claude-config` - Execute the most recent plan (highest number in docs/plans/)

## Prerequisites
- Plan file exists in `docs/plans/` (created via `/plan`)
- Plan has clear phases with Architecture Changes and/or File Change Details

## Next Commands
After implementation:
- `/review-claude-config` - Review the configuration changes
- `/push-to-remote` - Push to remote (after review cycle complete)
- `/plan-done` - Delete the completed plan
