---
name: jj-workflow
description: Jujutsu (jj) version control patterns including commit messages, bookmark management, and git integration. Use when working with jj commands.
---

# Jujutsu (jj) Workflow Patterns

## Commit Message Format

Same as git semantic commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

| Type | Description |
|------|-------------|
| feat | New feature implementation |
| fix | Bug fixes |
| docs | Documentation changes only |
| style | Code formatting, whitespace, missing semicolons |
| refactor | Code restructuring without behavior changes |
| perf | Performance improvements |
| test | Test additions or corrections |
| chore | Build process, auxiliary tools, dependencies |

### Rules

- Subject line: Max 50 characters, imperative mood, no period
- Body: Wrap at 72 characters, explain WHY not WHAT
- Write in English

## Key Differences from Git

- **No staging area**: All changes are automatically tracked
- **Mutable history**: Changes can be modified until pushed
- **Revisions not commits**: Work with revision IDs
- **Working copy is a commit**: Always in a change, not "uncommitted"

## Essential Commands

### Status and Diff

```bash
jj status              # View working copy state
jj diff                # View changes in current revision
jj log --limit 5       # View revision graph
jj log -r @ --no-graph # View current revision details
```

### Describe (Commit Messages)

```bash
# Single-line message
jj describe -m "<type>(<scope>): <subject>"

# Multi-line message
jj describe -m "<type>(<scope>): <subject>" -m "" -m "<body>"

# Describe specific revision
jj describe -r <revision> -m "message"
```

### Revision Specifiers

| Specifier | Meaning |
|-----------|---------|
| `@` | Current revision |
| `@-` | Previous revision |
| `@--` | Two revisions back |
| `main` | Local bookmark |
| `main@origin` | Remote bookmark |

## Bookmark Management

### Basic Operations

```bash
jj bookmark list                        # List all bookmarks
jj bookmark create <name> -r <revision> # Create new bookmark
jj bookmark set <name> -r <revision>    # Update existing bookmark
jj bookmark track <name>@origin         # Track remote bookmark
jj bookmark untrack <name>@origin       # Stop tracking
```

### First-Time Setup

If you see "Non-tracking remote bookmark exists":
```bash
jj bookmark track <bookmark>@origin
```

## Git Integration

### Fetch and Rebase

```bash
jj git fetch                    # Fetch remote changes
jj rebase -d main@origin        # Rebase onto remote
jj log -r 'main | main@origin'  # Compare local vs remote
```

### Push Workflow

```bash
# 1. Fetch latest
jj git fetch

# 2. Find target revision (non-empty)
jj log --limit 10 --no-graph -r '::@' | grep -v "(empty)"

# 3. Set bookmark
jj bookmark set main -r <target-revision>

# 4. Push
jj git push --branch main

# 5. CRITICAL: Sync git state
git checkout main
```

### Show Unpushed Changes

```bash
jj log -r '::@ & ~::main@origin'
```

## Working with Multiple Revisions

```bash
# View recent changes
jj log --limit 5

# Split changes if needed
jj split  # Interactive split

# Squash related changes
jj squash -r <rev2> --into <rev1>

# Describe each change
jj describe -r <rev1> -m "feat(core): add base implementation"
jj describe -r <rev2> -m "test(core): add unit tests"
```

## Error Handling

**"No bookmarks found in default push revset"**
```bash
jj bookmark set main -r @
```

**"Non-tracking remote bookmark exists"**
```bash
jj bookmark track main@origin
```

**"Refusing to push to remote"**
```bash
jj git fetch
jj rebase -d main@origin
```

**Rebase conflicts**
- Resolve conflicts in files
- Use `jj squash` to incorporate fixes
- Continue with push after resolution

## Safety Checks

Before pushing, always verify:

1. **Working copy state**: No unintended empty commits
   ```bash
   jj log -r @ --no-graph
   ```

2. **Bookmark pointing to correct revision**
   ```bash
   jj bookmark list
   ```

3. **Changes are rebased on latest remote**
   ```bash
   jj log -r 'main | main@origin' --no-graph
   ```

4. **Git will be in correct state**
   - Always run `git checkout <branch>` after push

## Related Commands

- `/jj-describe` - Update jj change description
- `/jj-git-push` - Push jj changes to git remote
