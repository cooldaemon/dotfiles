---
description: "Generate a message and update the current jj change description with semantic commit message."
allowed-tools: Bash(jj status), Bash(jj diff), Bash(jj describe), Bash(jj log), Read, Grep, Glob
---
 
You are an excellent developer. Review the content of this session and the modifications made, generate a semantic message, and update the current jj change description.

**IMPORTANT**: Commit messages must be written in English.

# Process
1. Check the current status using `jj status` to see what files have been modified.
2. Review the changes using `jj diff` to understand what was changed.
3. Generate a [Semantic Message] for the changes.
4. Update the change description using `jj describe -m "<message>"`.
5. Show the updated change with `jj log -r @` to confirm.

# What is a Semantic Message?

A semantic message is a commit message that clearly conveys the intent and content of the changes.

## Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

## Type Categories
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries

## Example
```
feat(auth): add user login functionality

Implemented login feature using JWT authentication.
- Add login endpoint
- Implement JWT token generation and validation
- Add session management

Closes #123
```

## Guidelines
- Keep the first line under 50 characters and concise
- Wrap the body at 72 characters
- Explain why you made the change, not just what you changed
- Write messages in English
- For jj, remember that changes are mutable until pushed, so focus on describing the current state of the change

## Jujutsu-specific notes
- Unlike git, jj automatically tracks all file changes, so no staging is needed
- Use `jj describe` to update the current change description
- If you need to split changes, use `jj split` before describing
- For multi-line messages, use `jj describe` without `-m` to open an editor, or use multiple `-m` flags