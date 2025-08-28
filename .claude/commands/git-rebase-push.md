---
description: "Safely pull remote changes with rebase and push to remote repository using a subagent."
---

I'll use the git-rebase-push subagent to safely synchronize with the remote repository.

The git-rebase-push subagent will:
- Check current branch and remote tracking status
- Fetch and rebase any remote changes
- Handle conflicts interactively if they occur
- Push local commits to the remote repository
- Ensure a clean, linear git history

## Prerequisites
- Local commits ready
- Remote repository accessible

## Next Commands
After pushing:
- `/implement-task` - Continue with next feature
- `/update-claude-md` - Update project documentation