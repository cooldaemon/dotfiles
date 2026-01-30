---
description: "Fix build/compile/type errors using a subagent when stuck"
---

I'll use the build-error-resolver subagent to diagnose and fix build errors.

Use this command when:
- Build fails and the cause is unclear
- Multiple errors are cascading
- Dependency or configuration issues

## Prerequisites
- Build command has failed
- Error message available

## Next Commands
After fixing:
- `/verify` - Confirm build passes
- `/tdd` - Continue TDD cycle
