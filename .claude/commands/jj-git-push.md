---
description: "Safely fetch remote changes, rebase if necessary, and push local jj changes to git remote."
allowed-tools: Bash(jj status), Bash(jj git fetch), Bash(jj git push), Bash(jj log), Bash(jj rebase), Bash(jj bookmark), Read
---

You are an excellent developer. Check for remote changes, rebase if necessary, and push local jj changes to the git remote repository.

**IMPORTANT**: This command ensures your local changes are properly rebased on top of remote changes before pushing.

# Process
1. Check current status and changes with `jj status`
2. Fetch remote changes with `jj git fetch`
3. Check if local changes need rebasing by comparing bookmarks
4. If behind remote, rebase onto the remote bookmark
5. Update the appropriate bookmark to point to current revision
6. Push changes to remote with `jj git push`

# Typical Workflow

## For main/master branch:
```bash
jj git fetch
jj log -r 'main | main@origin' --no-graph  # Compare local and remote
jj rebase -d main@origin  # If behind
jj bookmark set main -r @
jj git push --branch main
```

## For feature branches:
```bash
jj git fetch
jj bookmark create feature/my-feature -r @  # First time
# or
jj bookmark set feature/my-feature -r @  # Updating existing
jj git push --branch feature/my-feature
```

# Safety Checks

Before pushing:
- Verify working copy has no unintended empty commits
- Ensure bookmark tracking is properly configured
- Check that you're not accidentally pushing to the wrong branch
- Confirm rebase completed successfully if needed

# Bookmark Management

## First-time setup:
- If you see "Non-tracking remote bookmark exists", run:
  ```bash
  jj bookmark track <bookmark>@origin
  ```

## Common bookmark operations:
- Create new: `jj bookmark create <name> -r @`
- Update existing: `jj bookmark set <name> -r @`
- List bookmarks: `jj bookmark list`

# Handling Common Scenarios

## Scenario 1: Empty commit on top
If `jj log -r @` shows "(empty) (no description set)":
```bash
# Move bookmark to the last meaningful change
jj bookmark set main -r @-  # or @-- for two commits back
```

## Scenario 2: Multiple commits to push
```bash
# Check what will be pushed
jj log -r '::@ & ~::main@origin'
# Then proceed with normal push
```

## Scenario 3: Diverged from remote
```bash
jj git fetch
jj rebase -d main@origin
# Resolve any conflicts if they occur
jj bookmark set main -r @
jj git push
```

# Error Handling

Common issues:
- **"No bookmarks found in default push revset"**: Need to set a bookmark first
- **"Non-tracking remote bookmark exists"**: Run `jj bookmark track <name>@origin`
- **"Refusing to push to remote"**: Check if you need to rebase first
- **Rebase conflicts**: Resolve in files, then use `jj squash` to incorporate fixes

# Important Notes

- Unlike git, jj automatically tracks all file changes
- No need to "commit" - changes are already saved in jj
- Bookmarks in jj are equivalent to branches in git
- Always fetch before pushing to ensure you have latest remote state