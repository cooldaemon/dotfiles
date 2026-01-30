---
name: adr-patterns
description: Architecture Decision Records patterns including templates, naming conventions, and lifecycle management. Use when documenting significant architectural decisions.
---

# ADR (Architecture Decision Records)

## When to Create ADR

**Create ADR when:**
- Technology stack changes (new framework, database, language)
- Architecture pattern decisions (microservices, event-driven, etc.)
- Significant design decisions with long-term impact

**Do NOT create ADR for:**
- Daily implementation decisions
- Small feature additions
- Bug fixes
- Refactoring without architecture changes

## Directory Structure

```
docs/adr/
├── index.md          # ADR registry
├── 0001-title.md     # First ADR
├── 0002-title.md     # Second ADR
└── ...
```

## ADR Template

```markdown
# [Title of the Architectural Decision]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-NNNN]

## Context and Problem Statement
[Describe the context and problem statement in 2-3 sentences]

## Considered Options
* [Option 1] - Brief description
* [Option 2] - Brief description
* [Option 3] - Brief description

## Decision Outcome
Chosen option: "[Option X]", because [justification].

## Consequences

### Positive
* [Benefit 1]
* [Benefit 2]

### Negative
* [Drawback 1]
* [Drawback 2]
```

## Naming Convention

- Format: `NNNN-title-with-hyphens.md`
- Example: `0001-use-redis-for-vector-search.md`

## Lifecycle

- ADRs are **immutable** once accepted
- If a decision changes, create a **new ADR** that supersedes the old one
- **Never delete ADRs**, even if superseded
