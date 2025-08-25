---
description: "Safely fetch remote changes, rebase if necessary, and push local jj changes to git remote using a subagent."
---

I'll use the jj-git-push subagent to safely synchronize your jj changes with the remote git repository.

The jj-git-push subagent will:
- Fetch the latest remote changes
- Check if rebasing is needed and perform it
- Find the latest meaningful revision to push
- Update bookmarks appropriately
- Push changes to the remote repository
- Ensure git remains on the correct branch (not detached HEAD)
- Handle any conflicts or errors that arise

# Typical Workflow

## For main/master branch:
```bash
jj git fetch
jj log -r 'main | main@origin' --no-graph  # Compare local and remote
jj rebase -d main@origin  # If behind

# Find the latest meaningful revision (not empty)
jj log --limit 10 --no-graph | grep -v "(empty)" | head -1
# Or check descendants of current bookmark
jj log -r '::@ & descendants(main)'

jj bookmark set main -r <target-revision>
jj git push --branch main

# Ensure git is on the branch (not detached HEAD)
git checkout main
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

## Scenario 2: Multiple commits to push (COMMON)
When you have multiple related changes (e.g., created with multiple `jj new`):
```bash
# View all your unpushed changes
jj log -r '::@ & ~::main@origin'

# Find the latest meaningful revision
# Option 1: Look for the last non-empty revision
jj log --limit 10 --no-graph -r '::@' | grep -v "(empty)" | head -1

# Option 2: If you know the revision ID or pattern
jj log -r '::@ & description(glob:"*")' --no-graph

# Move bookmark to the appropriate revision
jj bookmark set main -r <revision-id>

# Push and ensure git follows
jj git push --branch main
git checkout main
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
- After pushing, always run `git checkout <branch>` to avoid git's detached HEAD state
- When you have multiple changes, make sure to push the latest meaningful revision, not an empty one

# Best Practices

1. **Always check what you're pushing**: Use `jj log` to understand your revision graph
2. **Handle multiple revisions**: When using multiple `jj new`, remember to set bookmark to the latest complete change
3. **Keep git in sync**: After jj operations, ensure git sees the correct branch state
4. **Track remote bookmarks**: First time pushing requires `jj bookmark track <name>@origin`