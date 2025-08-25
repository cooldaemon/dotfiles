---
description: "Manage Architecture Decision Records (ADRs) using a specialized subagent"
---

I'll use the adr subagent to manage Architecture Decision Records for your project.

The adr subagent will:
- Check and create the docs/adr directory structure if needed
- Analyze git history and session context for technical decisions
- Generate new ADR files with proper numbering
- Update the index.md file automatically
- Ensure all ADRs follow the standard template format