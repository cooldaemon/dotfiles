---
id: PLAN-0003
title: Secret Management Patterns
created: 2026-03-07
---

# Implementation Plan: Secret Management Patterns

## Overview

Add a new "Sensitive Data Logging" vulnerability pattern to the security-patterns skill, and add minimal detection signals to security.md, code-reviewer, and coding-style to close the gap across all defense layers.

**Motivation**: A prompt injection attack was demonstrated where malicious code reads `.env` files and prints credentials to stdout disguised as debug logging. Current security-patterns covers hardcoded secrets but not the inverse vector: code that reads secrets and outputs them.

**Scope limitation**: These patterns strengthen review-time detection. They do not prevent Claude from executing malicious code during a prompt injection attack. Runtime sandboxing and tool permission controls are separate concerns.

## Architecture Changes

| ID | File Path | Action | Description |
|----|-----------|--------|-------------|
| 1 | `.claude/skills/security-patterns/SKILL.md` | MODIFY | Add "Sensitive Data Logging (CRITICAL)" pattern after "Hardcoded Secrets" |
| 2 | `.claude/rules/security.md` | MODIFY | Add secret output detection to Quick Check |
| 3 | `.claude/agents/code-reviewer.md` | MODIFY | Add secret output detection to Code Integrity checklist |
| 4 | `.claude/skills/coding-style/SKILL.md` | MODIFY | Add cross-reference to security-patterns |

## File Change Details

### 1. `.claude/skills/security-patterns/SKILL.md` (MODIFY)

Insert after line 11 (end of "Hardcoded Secrets" pattern), before line 13 ("SQL Injection"):

```markdown
### Sensitive Data Logging (CRITICAL)
Never log, print, or output secrets to stdout/stderr. Code that reads secrets from .env, config files, or environment variables must never pass those values to print(), console.log(), logger calls, or string formatting that reaches output.

**Attack pattern**: Malicious code disguised as fixes that reads `.env` or config and prints key-value pairs, leaking secrets through CI/CD logs or log aggregation systems.

**Detection signals**:
- `dotenv_values()`, `load_dotenv()`, `process.env` combined with print/log/console output
- Loops iterating over environment or config dictionaries with output statements
- "Debug" or "diagnostic" code that dumps configuration values
- Code iterating over all env vars or config entries without filtering sensitive keys

**Prevention**:
- Never iterate over all environment variables without an explicit allowlist
- Treat `.env` files as sensitive -- code that reads them should never output their contents
```

### 2. `.claude/rules/security.md` (MODIFY)

Add one bullet to "Quick Check (Before Commit)" section after line 15:

```markdown
- No code that reads secrets (.env, config) and outputs/logs their values
```

### 3. `.claude/agents/code-reviewer.md` (MODIFY)

Add one bullet to "Code Integrity (CRITICAL)" section after line 23:

```markdown
- Code that reads secrets (.env, config, env vars) and outputs/logs their values
```

### 4. `.claude/skills/coding-style/SKILL.md` (MODIFY)

Change line 441 from:

```
- Never log sensitive data (passwords, tokens, PII)
```

to:

```
- Never log sensitive data (passwords, tokens, PII) -- see security-patterns skill for attack vectors
```

## What Was Dropped

1. **Separate "Secret Management Architecture" pattern** -- Merged into the single "Sensitive Data Logging" pattern as detection signals and prevention guidance. Architectural recommendations (Vault, Secrets Manager, 1Password CLI) dropped from global skill; they belong in project-level ADR decisions.
2. **Adding `security-patterns` skill to `how-planner` agent** -- Replaced by one line in `security.md` global rule, which all agents already load. Avoids 113 lines of token bloat on every planning session.

## Progress Tracking

- [x] Step 1: Add Sensitive Data Logging pattern to security-patterns skill
- [x] Step 2: Add secret output check to security.md Quick Check
- [x] Step 3: Add secret output detection to code-reviewer Code Integrity checklist
- [x] Step 4: Add cross-reference in coding-style Logging section

## Critique Log

| # | Source | Severity | Challenge / Proposal | Resolution | Evidence |
|---|--------|----------|---------------------|------------|----------|
| C1 | Critic | HIGH | Scope Mismatch -- Pattern B is architectural guidance, not detection | Accepted: Pattern B merged into Pattern A with detection-focused signals only | security-patterns existing patterns are all detection-focused |
| C2 | Critic | HIGH | Wrong Layer -- Adding security-patterns skill to how-planner causes token bloat (113 lines on every plan) | Accepted: Dropped skill addition; replaced with 1-line bullet in security.md global rule | how-planner already loads rules; skill would add 113 lines per session |
| C3 | Critic | MEDIUM | Attack Vector Gap -- Plan does not address prompt injection root cause | Accepted: Scope limitation note added to plan overview | Patterns are defense-in-depth at review layer, not runtime prevention |
| C4 | Critic | MEDIUM | Duplication -- coding-style line 441 overlaps with Pattern A | Accepted: Cross-reference added from coding-style to security-patterns | coding-style:441 says "Never log sensitive data"; security-patterns provides detection details |
| O1 | Optimizer | HIGH | Merge Pattern B into Pattern A for consistency with existing single-section convention | Accepted: One merged pattern with detection signals and prevention | All existing security-patterns entries are single self-contained sections |
| O2 | Optimizer | HIGH | Add 1-line detection signal to code-reviewer Code Integrity checklist | Accepted: Added as file change #3 | Code-reviewer runs after every US in TDD flow; earliest review checkpoint |
| O3 | Optimizer | MEDIUM | Add 1-line Quick Check bullet to security.md global rule | Accepted: Added as file change #2 | All agents load rules; provides baseline awareness without skill additions |
| O4 | Optimizer | -- | Cross-reference in coding-style (same as C4) | Accepted: Same resolution as C4 | Avoids two sources of truth |
| O5 | Optimizer | -- | Scope limitation note (same as C3) | Accepted: Same resolution as C3 | Honest framing of what patterns can and cannot prevent |
