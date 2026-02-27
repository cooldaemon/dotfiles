# Targeting Examples

## Example 1: API Package Work

**Session Context:**
- 12 files modified in `packages/api/src/`
- Commands run: `npm run test:api`, `npm run migrate`
- Discussion: "API routes must handle timeouts gracefully"

**Decision:** Update `packages/api/CLAUDE.md`
- Primary directory: `packages/api/`
- Content type: Component-specific convention

## Example 2: Project-Wide Refactoring

**Session Context:**
- 5 files in `packages/api/`, 4 in `packages/frontend/`, 3 in `packages/shared/`
- Commands run: `npm run build:all`, `npm test`
- Discussion: "Moving to ESM modules across entire project"

**Decision:** Update root `CLAUDE.md`
- Primary directory: Multiple (distributed)
- Content type: Cross-cutting architectural change

## Example 3: Frontend Testing Setup

**Session Context:**
- 8 files in `packages/frontend/tests/`
- Commands run: `npm run test:frontend`, `npx playwright test`
- Discussion: "Playwright requires specific viewport settings"

**Decision:** Update `packages/frontend/CLAUDE.md`
- Primary directory: `packages/frontend/`
- Content type: Component-specific testing

## Example 4: Git Workflow Convention

**Session Context:**
- 1 file modified: `.github/pull_request_template.md`
- Discussion: "All PRs must include test evidence"

**Decision:** Update root `CLAUDE.md`
- Primary directory: Root (affects all packages)
- Content type: Shared convention
