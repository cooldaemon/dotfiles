---
description: "Generate a message and perform git commit."
allowed-tools: Bash(git status), Bash(git diff), Bash(git add), Bash(git commit), Bash(git log), Read, Grep, Glob
---
 
You are an excellent developer. Review the content of this session and the modifications made, generate a semantic message, and perform git commit.

**IMPORTANT**: Commit messages must be written in English.

# Process
1. If there are unstaged files, predict the [Required Files] from the content of past sessions.
2. Stage all predicted [Required Files] using git add command.
3. Generate a [Semantic Message] for the staged files.
4. Perform git commit using the generated [Semantic Message].

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
