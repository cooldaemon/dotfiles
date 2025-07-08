---
description: "Update project's CLAUDE.md with session insights"
allowed-tools: Read, Write, Edit, MultiEdit, Grep, Glob
---

# Update CLAUDE.md

Update the project's CLAUDE.md file with important information from the current session.

## Instructions

At the end of a coding session, review the conversation and extract important information that should be remembered for future sessions. This includes:

- Project-specific rules and conventions discovered during the session
- Coding standards and patterns used in the project
- Important technical decisions or constraints
- Key file locations and project structure insights
- Testing approaches and commands
- Build and deployment processes
- Any gotchas or important notes about the codebase

Update or create the CLAUDE.md file in the project root with this information, organizing it into clear sections. If CLAUDE.md already exists, append new information to the appropriate sections or create new sections as needed.

## Format

The CLAUDE.md file should be structured with clear headings and include:

```markdown
# Project: [Project Name]

## Project Rules and Conventions
- [Important conventions discovered]

## Coding Standards
- [Language-specific standards]
- [Framework conventions]

## Project Structure
- [Key directories and their purposes]
- [Important file locations]

## Testing
- [Test commands]
- [Testing approach]

## Build and Deployment
- [Build commands]
- [Deployment process]

## Important Notes
- [Any gotchas or special considerations]
```

Only include sections that have relevant information from the session.