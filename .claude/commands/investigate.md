---
description: "Investigate a bug using test-first methodology with interactive analysis"
---

I'll investigate this bug using the bug-investigation skill workflow.

**This runs in the main session** (no sub-agent) for interactive investigation with the user.

## Investigation Workflow

1. **Clarify**: Gather reproduction steps, expected vs actual behavior
2. **Reproduce**: Write a test that captures the bug scenario
3. **Fix**: Minimal change to make the test pass
4. **Escalate**: If reproduction fails after 2 attempts, use logging approach

See the `bug-investigation` skill for detailed phases and decision flowchart.

## After Investigation

Based on findings, the appropriate next command will be recommended:

| Finding | Next Command |
|---------|-------------|
| UX/flow needs to change | `/plan-ux` |
| Architecture/system design decision needed | `/plan-how` |
| Bug reproduced, fix is straightforward | `/tdd` |
| Bug reproduced AND UX change needed | `/plan-ux` |
