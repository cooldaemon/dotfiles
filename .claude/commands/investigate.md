---
description: "Investigate a bug or production incident using test-first methodology with interactive analysis"
---

I'll investigate this issue using the appropriate workflow.

**This runs in the main session** (no subagent) for interactive investigation with the user.

## Triage: Bug or Production Incident?

Before starting investigation, determine the category:

| Signal | Category | Approach |
|--------|----------|----------|
| "Production is down", "users are affected", "alerts firing", SEV1/SEV2 | **Production Incident** | Use `incident-response-patterns` skill: classify severity, assign roles, follow communication cadence |
| "Something is broken", "doesn't work", "regression", "error in tests" | **Code Bug** | Continue with bug-investigation workflow below |
| Ambiguous | Ask user | "Is this affecting production users right now, or is this a development-time bug?" |

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
| Production incident -- needs post-mortem | Use `incident-response-patterns` post-mortem template |
| Production incident -- needs SLO/alerting changes | `/plan-how` |
