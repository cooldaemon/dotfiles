---
description: "Safely pull remote changes with rebase and push to remote repository."
allowed-tools: Bash(git status), Bash(git pull), Bash(git push), Bash(git log), Bash(git branch), Read
---

You are an excellent developer. Check for remote changes, pull with rebase if necessary, and push local commits to the remote repository.

**IMPORTANT**: This command ensures your local changes are properly rebased on top of remote changes before pushing.

# Process
1. Check current branch and remote tracking information
2. Fetch remote changes without merging
3. Check if local branch is behind remote
4. If behind, perform `git pull --rebase` to incorporate remote changes
5. If rebase conflicts occur, handle them interactively:
   - Show each conflicted file and its conflict details
   - Ask user for resolution strategy for each conflict
   - Apply the resolution according to user's instructions
   - Stage resolved files with `git add`
   - Continue until all conflicts are resolved
6. After successful rebase (or if already up-to-date), push to remote

# Rebase Strategy

The command uses `git pull --rebase` which:
- Fetches remote changes
- Temporarily removes your local commits
- Applies remote commits to your branch
- Re-applies your local commits on top

This creates a linear history without merge commits.

# Safety Checks

Before pushing:
- Verify no uncommitted changes exist
- Ensure branch tracks a remote branch
- Check that local branch is not diverged in a problematic way
- Confirm rebase completed successfully

# Conflict Resolution Process

When rebase conflicts occur:

1. **Identify conflicts**: List all files with conflicts
2. **For each conflicted file**:
   - Display the conflict content (showing both versions)
   - Ask user: "How would you like to resolve this conflict?"
   - Options:
     - Accept current changes (ours)
     - Accept incoming changes (theirs)
     - Provide custom resolution
     - Skip this file for now
     - Abort the entire rebase
3. **Apply resolution**:
   - Edit the file according to user's choice
   - Remove conflict markers
   - Stage the resolved file with `git add`
4. **Continue or abort**:
   - After all conflicts resolved: `git rebase --continue`
   - If user chooses to give up: `git rebase --abort`

# Error Handling

Common scenarios:
- **No remote tracking**: Set upstream branch before pushing
- **Rebase conflicts**: Interactive resolution process (see above)
- **Uncommitted changes**: Stash or commit before proceeding
- **Network issues**: Retry with appropriate error messages

# Example Flow
```
1. git status (check working directory)
2. git fetch (get remote updates)
3. git status (check if behind remote)
4. git pull --rebase (if behind)
5. git push (push to remote)
```
