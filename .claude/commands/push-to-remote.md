---
description: "Safely pull remote changes with rebase and push to remote repository using a subagent."
---

I'll use the push-to-remote subagent to safely synchronize with the remote repository.

The push-to-remote subagent will:
- Check current branch and remote tracking status
- Fetch and rebase any remote changes
- Handle conflicts interactively if they occur
- Push local commits to the remote repository
- Ensure a clean, linear git history

## Prerequisites
- Local commits ready
- Remote repository accessible
- Fixup commits from TDD cycle will be autosquashed before pushing

## Next Commands
After pushing:
- `/update-claude-md` - Update project documentation
