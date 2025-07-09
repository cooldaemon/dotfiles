---
description: "Generate a message and perform git commit with pre-commit validation."
allowed-tools: Bash(git status), Bash(git diff), Bash(git add), Bash(git commit), Bash(git log), Read, Grep, Glob
---
 
You are an excellent developer. Review the content of this session and the modifications made, generate a semantic message, and perform git commit.

**IMPORTANT**: Commit messages must be written in English.

# Process
1. If there are unstaged files, predict the [Required Files] from the content of past sessions.
2. Stage all predicted [Required Files] using git add command.
3. Generate a [Semantic Message] for the staged files.
4. Perform git commit using the generated [Semantic Message].
5. **CRITICAL: Handle commit failures properly**:
   - If `git commit` fails with a non-zero exit code, **NEVER ignore the error**
   - **DO NOT retry the commit if there are actual errors**
   - **ABSOLUTELY NEVER use `--no-verify` flag** - this is strictly forbidden
   - Common pre-commit hook failures and how to fix them:
     - **Linting errors (ESLint, Prettier, Black, etc.)**: Run the appropriate fix command (e.g., `npm run lint:fix`, `prettier --write`, `black .`)
     - **Type checking errors (TypeScript, mypy, etc.)**: Fix the type errors in the code
     - **Test failures**: Fix the failing tests or the code that broke them
     - **Security vulnerabilities**: Update dependencies or fix the security issues
   - If the commit fails:
     1. Analyze the error message to understand what failed
     2. Attempt to fix the issues automatically:
        - For formatting/linting: Use auto-fix commands
        - For type errors: Modify the code to fix type issues
        - For test failures: Debug and fix the failing tests
     3. After fixing, run `git add` for modified files and retry the commit
     4. Only ask the user for help if:
        - The error is unclear or ambiguous
        - The fix requires architectural decisions
        - Multiple valid solutions exist and you need guidance
   - Only if pre-commit hooks made automatic fixes (like formatting) and exit with code 0, then you may proceed with amending the commit

# Additional Checks Before Commit

**IMPORTANT**: Always run these checks before committing if they exist in the project:
- Linting: Check for `npm run lint`, `ruff check`, `rubocop`, etc.
- Type checking: Check for `npm run typecheck`, `tsc`, `mypy`, etc.
- Tests: Check for `npm test`, `pytest`, `go test`, etc.

If any of these commands fail, fix the issues before proceeding with the commit.

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
