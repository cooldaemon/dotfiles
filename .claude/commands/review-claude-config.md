---
description: "Review Claude Code configuration changes (.claude/) for quality, consistency, and architectural compliance"
---

I'll use the claude-config-reviewer subagent to review the configuration changes.

The claude-config-reviewer subagent will:
- Detect changed `.claude/` files via git diff
- Review agent, command, skill, and rule files against quality checklists
- Check cross-references for stale links
- Verify architecture principles (skills=WHAT, agents=HOW, no duplication)
- Persist report to `docs/config-reviews/` if issues found

## Prerequisites
- Configuration changes exist (from `/update-claude-config` or manual edits)

## Next Commands
After review:
- `/update-claude-config` - Fix issues found in review
- `/git-commit` - Commit the changes
