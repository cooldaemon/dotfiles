---
description: "Refactor code according to general coding standards and project-specific CLAUDE.md if available"
allowed-tools: Read, Edit, MultiEdit, Grep, Glob, Bash
---

Refactor the specified files or directories according to the coding standards defined in this file. If a CLAUDE.md file exists in the project, its rules take precedence over the general standards listed here.

**IMPORTANT**: Always check for a CLAUDE.md file in the project root first. Project-specific standards override these general guidelines.

# Process

1. Check for CLAUDE.md in the project root directory
2. If CLAUDE.md exists, use its standards (overriding the general standards below)
3. Analyze the specified file(s) or all files in the specified directory
4. Identify violations of applicable coding standards
5. Apply refactoring to align with the standards
6. Run project-specific verification commands if available

# General Refactoring Standards

**NOTE**: These are general guidelines based on "Tidy First?" by Kent Beck and general best practices. If CLAUDE.md exists in the project, its standards take precedence.

## Structure and Readability Tidyings

### Guard Clauses
- Convert nested conditionals to early returns
- Place exceptional cases at the beginning
- Keep the main logic at the base indentation level

### Dead Code Removal
- Remove unused functions, variables, and imports
- Delete commented-out code
- Remove unreachable code paths

### Extract Helper
- Extract complex expressions into well-named helper functions
- Group related functionality together
- Create reusable utilities for common patterns

### Explaining Variables & Constants
- Replace complex expressions with descriptive variables
- Extract magic numbers/strings into named constants
- Use intermediate variables to clarify multi-step calculations

### Chunk Statements
- Group related statements together
- Add blank lines between logical sections
- Order declarations closer to their usage

### Normalize Symmetries
- Make similar code look similar
- Use consistent patterns for similar operations
- Align parallel structures

## Code Organization

### One Pile
- Consolidate related code into a single location
- Avoid scattering related logic across files
- Group similar functions together

### Separation of Concerns
- Separate business logic from presentation
- Keep I/O operations distinct from processing
- Isolate external dependencies

### Single Responsibility
- Each function should have one clear purpose
- Break down complex functions into smaller ones
- Name functions to clearly express their single task

## Clean Code Practices

### Explicit Parameters
- Make dependencies explicit through parameters
- Avoid hidden state and global variables
- Prefer pure functions when possible

### Error Handling
- Use consistent error handling patterns
- Fail fast for missing requirements
- Provide clear, actionable error messages
- Handle errors at appropriate abstraction levels

### Self-Documenting Code
- Use descriptive names that eliminate need for comments
- Structure code to be readable without documentation
- Let the code tell the story

# Verification Steps

After refactoring, run appropriate project commands:
- Look for Makefile, package.json scripts, or other build tools
- Run formatters/linters if available
- Run tests if available
- Common patterns: `make test`, `npm test`, `pytest`, etc.

# Refactoring Safety

- **Maintain Functionality**: Never break existing behavior during refactoring
- **Small Steps**: Apply tidyings incrementally, testing after each change
- **Stage Large Changes**: For extensive refactoring, work in reviewable chunks
- **Test Coverage**: Ensure tests exist before refactoring; add them if missing
- **Version Control**: Commit after each successful tidy for easy rollback

# Example Flow

```bash
# User requests refactoring
/refactor path/to/file.py

# Claude performs:
# 1. Checks for CLAUDE.md in project root
# 2. Reads and analyzes the file
# 3. Identifies opportunities for tidying:
#    - Guard clauses for nested conditions
#    - Dead code to remove
#    - Complex expressions to extract
#    - Magic values to name
#    - Related code to group
# 4. Applies tidyings incrementally
# 5. Runs verification after each change
# 6. Reports improvements made
```