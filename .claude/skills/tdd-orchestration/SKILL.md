---
name: tdd-orchestration
description: "Team-lead orchestration for TDD agent teams. Defines team setup, initiation messages, and completion handling. Agent-to-agent protocol is defined in each agent's own file. Use when the main session orchestrates a TDD team via /tdd-team command. Do NOT use for general testing guidance -- use testing-principles instead."
durability: encoded-preference
---

# TDD Orchestration Protocol

## Shared Context

Context discovery, language detection, plan display, review report integration, and autonomous execution policy are defined in the `tdd-context` skill. Load it alongside this skill: both must be active in the main session during team mode.

Language detection is each agent's own responsibility (via marker files). Team-lead does NOT need to detect or pass language information.

## Team Setup

### E2E Detection
Check for browser test framework markers BEFORE creating the team:
- `playwright.config.ts` or `playwright.config.js` -> Playwright
- `cypress.config.js` or `cypress.config.ts` -> Cypress
- Neither -> no e2e-runner

### TeamCreate
```
Browser tests exist:  TeamCreate -> spawn red, green, refactor, e2e (4 teammates)
No browser tests:     TeamCreate -> spawn red, green, refactor (3 teammates)
```

Phase agents run unit/integration tests directly via Bash. Only browser tests are delegated to e2e-runner.

## Team-Lead Messages

Team-lead only sends to **red** (the entry point). Inter-agent baton passing is defined in each agent's Teammate Protocol.

### New Feature (with plan)
`Phase: RED. Plan: [plan directory path]. US: [current US identifier].`

### Direct Request (no plan)
`Phase: RED. Direct: [behavioral description of desired feature].`

### Review Fix
`Phase: RED. Review fixes: [issue IDs and descriptions]. Target commit: [hash].`

Group issues by US/commit target and send as a batch. Each agent commits its own fixup targeting the relevant US commit.

## Waiting and Completion

### Wait Condition
Wait for refactor's message: `Phase: REFACTOR complete.`

Agents also send `Status:` messages for monitoring. If an agent sends `Escalation:`, intervene.

### On Completion (Team-lead)
1. Output: "US complete. Review will run automatically."
2. **Shutdown team** (same pattern as plan-ux/plan-how -- team lifecycle ends)
3. **STOP** -- hand off to user. Auto-review runs per tdd-team.md command.

## Bug Investigation Mode

Use `Skill` tool to load `bug-investigation`.

1. Investigate the bug directly (read code, understand root cause)
2. Describe the bug as a **behavioral specification** (WHAT is broken, not WHERE in code)
3. Send to red: `Phase: RED. Direct: [behavioral specification]`
4. Agents handle the rest autonomously

## Phase Gate Verification (Troubleshooting)

Primary enforcement is each agent's file access rules. If monitoring reveals anomalies (e.g., Red reporting production file edits), inspect with `git show --name-only --format="" HEAD`.

## Cost Note

Team mode uses more total tokens than single-agent mode (multiple context windows, redundant file reads, message overhead). This is the trade-off for context isolation. tdd-green and e2e-runner use Sonnet to reduce cost for mechanical phases.
