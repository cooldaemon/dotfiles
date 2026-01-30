---
description: "Generate a message and perform git commit with pre-commit validation using a subagent."
---

I'll use the git-commit subagent to handle the commit process. Let me provide context from our current session.

The git-commit subagent will:
- Analyze the repository changes
- Stage appropriate files based on our session context
- Generate a semantic commit message
- Handle any pre-commit hook failures
- Complete the commit successfully

## Prerequisites
- Changes staged or ready to stage
- Tests passing

## Next Commands
After committing:
- `/git-rebase-push` - Push to remote repository