---
description: "Refactor code according to general coding standards and project-specific CLAUDE.md using a subagent"
---

I'll use the refactor subagent to improve the code quality of the specified files.

The refactor subagent will:
- Check for project-specific CLAUDE.md standards
- Analyze code for improvement opportunities
- Apply clean code principles and tidyings
- Run verification tests to ensure functionality
- Maintain backward compatibility

## Prerequisites
- All tests passing (green)
- Working implementation

## Next Commands
After refactoring:
- `/git-commit` - Commit the improvements
- `/implement-task` - Continue with next task
- `/update-claude-md` - Update project docs if needed