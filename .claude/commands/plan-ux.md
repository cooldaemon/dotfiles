---
description: "Create UX plan with user stories, ASCII art sketches, and Gherkin scenarios using designer sub-agent"
---

I'll use the designer subagent to create a UX plan defining user value.

The designer subagent will:
- Gather requirements from user (asks clarifying questions if ambiguous)
- For existing UI modifications: read current components, create Before/After ASCII Art
- For new UI: create ASCII Art sketches
- Define User Stories with Gherkin scenarios
- Write to `docs/plans/{feature-name}/ux.md`

## Prerequisites
- Clear understanding of the feature request or user problem
- Access to relevant UI components (for modifications)

## Next Commands
After user approves ux.md:
- `/plan-how` - Create implementation plan (Phase 2: HOW)
