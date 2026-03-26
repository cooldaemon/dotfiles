---
name: tdd-context
description: "Use when executing TDD workflows that need plan discovery, review integration, or language detection. Always loaded by tdd-guide and tdd-team; do NOT use standalone."
durability: encoded-preference
---

# TDD Context

## Context Discovery (On Startup)

Check BOTH directories for context:

```bash
ls -d docs/plans/*/ 2>/dev/null
ls docs/code-reviews/*.md 2>/dev/null
```

| Source | Location | Purpose |
|--------|----------|---------|
| **Plan** | `docs/plans/NNNN-{feature-name}/` | ux.md (Gherkin) + how.md (EARS) |
| **Code Review** | `docs/code-reviews/*.md` | Issues to fix |

### Priority
1. Both exist: Address code review issues first, then implement plan
2. Only plan: Implement according to EARS criteria
3. Only review: Fix issues systematically
4. Neither: Proceed with user's direct request

### Plan Display
If plan exists:
1. Read `ux.md` for User Stories and Gherkin scenarios
2. Read `how.md` for Global context and per-US EARS
3. Display: "Found plan: [feature name]"
4. List User Stories with their Gherkin scenarios and EARS criteria

## Language Detection

Detect project language from marker files:

| Marker File | Language |
|-------------|----------|
| `pyproject.toml`, `setup.py` | Python |
| `package.json` | TypeScript/JS |
| `go.mod` | Go |

If unclear, check existing test files or ask the user.

Each consumer detects the language independently and loads the matching on-demand skill itself.

## Code Review Report Integration

### On Startup (if report exists)
1. Read the latest report (most recent by filename timestamp)
2. Parse pending issues (lines matching `- [ ] [XX-NNN]`)
3. Display: "Found code review report with N pending issues"
4. List the pending issues

### Fix Policy

| User Input | Behavior |
|------------|----------|
| With issue IDs (e.g., `CR-001 CR-003`) | Fix only the specified issue IDs |
| No arguments | Fix ALL remaining `- [ ]` items |

When filtering by issue ID:
1. Parse issue IDs from user's message (pattern: `XX-NNN`)
2. Match against pending `- [ ] [XX-NNN]` lines
3. Fix only matched items
4. If ID not found, warn: "Issue [ID] not found in report"
5. Do NOT update `status: RESOLVED` unless ALL items resolved

When no filter: fix ALL remaining `- [ ]` items unconditionally. The user has already curated the report by removing items they do not want fixed.

### Resolution Tracking
When an issue is addressed:
1. Mark complete: change `- [ ]` to `- [x]`
2. Add entry to Resolution Log table with date and notes
3. Update frontmatter `status: IN_PROGRESS`
4. Commit per the consumer's checkpoint strategy (e.g., Git Fixup Checkpointing in tdd-guide)

### On Completion
Report deletion is handled by the invoking command (main session with user confirmation), not by agents. See the command file for the completion check.

**Selective fix** (some `- [ ]` remain): Keep `status: IN_PROGRESS`, confirm fixed count.

## Autonomous Execution Policy

When a plan or code review report exists, complete ALL items autonomously. Do NOT ask "Should I continue?" between steps.

**Only stop and ask the user when:**
- An unexpected error blocks progress and cannot be resolved
- Requirements are ambiguous with multiple valid interpretations
- A test reveals a design flaw that requires changing the plan
