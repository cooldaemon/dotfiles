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
- Plan file exists in `docs/plans/` (created via `/plan-claude-config`)
- Plan has clear phases with Architecture Changes and/or File Change Details

## Git Policy
The claude-config-updater agent manages its own git commits (semantic for plan execution, fixup for review fixes). Do NOT override this in the Task prompt.

## Auto-Review

After the claude-config-updater subagent completes successfully, automatically spawn the claude-config-reviewer subagent to review the changes. This replaces the need to manually run `/review-claude-config`.

**IMPORTANT**: After the review report is presented, STOP and wait for the user's decision. Do NOT automatically start fixing issues. If the user wants fixes applied, re-run `/update-claude-config` (it will detect the review report and enter Review Fix Mode).

## Next Commands
After implementation and review:
- `/update-claude-config` - Fix issues found in review (reads the review report)
- `/push-to-remote` - Push to remote (after review cycle complete)
- `/plan-done` - Delete the completed plan
