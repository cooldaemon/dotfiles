---
description: "Create Architecture Decision Records (ADRs) using the adr-architect agent"
---

I'll use the adr-architect agent to create an Architecture Decision Record for your project.

The adr-architect agent will:
- Check and create the docs/adr directory structure if needed
- Analyze the technical decision context
- Generate a new ADR file with proper numbering
- Update the index.md file automatically
- Follow the standard ADR template from adr-patterns skill

## Plan Integration

If a plan exists at `docs/plans/NNNN-{feature-name}/how.md`, the adr-architect agent will:
- Read the "ADR Candidates" section for topics and context
- Create ADRs for the listed candidates
- Update how.md with links to the created ADR files

Invoke with a plan number or feature name to process candidates from a specific plan:
```
/create-architecture-decision 0002
/create-architecture-decision {feature-name}
```

## Next Commands
After creating ADRs from a plan:
- `/tdd` - Implement with test-driven development

## Prerequisites
- Clear understanding of the problem
- Options considered
- Decision rationale
