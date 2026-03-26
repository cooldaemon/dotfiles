---
description: "Experimental: Multi-agent TDD with context-isolated Red/Green/Refactor phases"
---

**EXPERIMENTAL**: This command uses TeamCreate for multi-agent TDD. For the standard single-agent TDD workflow, use `/tdd`.

## Usage

```
/tdd-team                      # Full TDD cycle or fix ALL review issues
/tdd-team CR-001 CR-003        # Fix only specific review issues
/tdd-team [free-text request]  # Direct TDD request without plan
```

## Execution

Load skills via `Skill` tool: `tdd-context` (shared context) + `tdd-orchestration` (team protocol). For bug mode, also load `bug-investigation`.

Follow the `tdd-orchestration` skill protocol:
1. Discover context: plans (`docs/plans/*/`) and code reviews (`docs/code-reviews/*.md`)
2. Detect E2E: `playwright.config.*` or `cypress.config.*` for e2e-runner
3. Create team: TeamCreate with red, green, refactor + e2e-runner if browser tests
4. Send to red:
   - With plan: plan path + current US identifier
   - Direct request: behavioral description from user's free-text input
5. Wait for refactor's completion, then shutdown team and run auto-review

## Auto-Review

After completing a US (plan mode or direct request -- NOT review fix mode), execute `/code-review` logic. If no issues: "US complete. Code review passed. Run `/tdd-team` for the next US or `/push-to-remote` when ready." If issues: write report to `docs/code-reviews/`.

**IMPORTANT**: After review report, STOP and wait for user's decision.

## Report Completion Check

After review fix mode completes, check the report:

1. Read the report file, count remaining `- [ ]` items
2. **Some remain**: Output "Fixed [N] issues. [M] issues remain." STOP.
3. **All resolved**: Update frontmatter `status: RESOLVED`, then ask user: "All review issues resolved. Delete the report?"
4. If user confirms: delete report file, confirm "Report deleted: [filename]"

## Next Commands
- `/tdd-team` - Fix review issues, or implement next US
- `/tdd` - Switch to single-agent mode
- `/push-to-remote` - Autosquash fixups and push when ready
