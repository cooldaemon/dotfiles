# YAML Frontmatter Reference

Complete reference for skill YAML frontmatter fields.

## Required Fields

```yaml
---
name: skill-name-in-kebab-case
description: What it does and when to use it. Include specific trigger phrases.
---
```

### name
- **Format**: kebab-case only
- **Restrictions**: No spaces, no capitals
- **Must match**: folder name

### description
- **Max length**: 1024 characters
- **Structure**: `[What it does] + [When to use it] + [Key capabilities]`
- **Must include**: Trigger phrases users would say
- **Forbidden**: XML angle brackets (< >)

## Optional Fields

```yaml
---
name: skill-name
description: [required description]
license: MIT
compatibility: Requires Python 3.10+, network access for API calls
metadata:
  author: Company Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [project-management, automation]
---
```

### license
- **Use case**: Open source skills
- **Common values**: MIT, Apache-2.0, BSD-3-Clause

### compatibility
- **Max length**: 500 characters
- **Use case**: Environment requirements
- **Examples**:
  - "Requires Node.js 18+"
  - "Claude.ai only (uses code execution)"
  - "Needs network access for external APIs"

### metadata
- **Format**: Any custom key-value pairs
- **Suggested keys**:
  - `author`: Creator name/organization
  - `version`: Semantic version (1.0.0)
  - `mcp-server`: Associated MCP server name
  - `category`: Skill category
  - `tags`: Array of keywords
  - `documentation`: URL to docs
  - `support`: Support contact

## Security Restrictions

### Forbidden in frontmatter
- XML angle brackets (< >) - injection risk
- Code execution in YAML (safe parsing)
- "claude" or "anthropic" prefix in name (reserved)

### Why?
Frontmatter appears in Claude's system prompt. Malicious content could inject instructions.

## Description Examples

### Good Descriptions

```yaml
# Specific and actionable
description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".

# Includes trigger phrases
description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".

# Clear value proposition with negative trigger
description: Advanced data analysis for CSV files. Use for statistical modeling, regression, clustering. Do NOT use for simple data exploration (use data-viz skill instead).
```

### Bad Descriptions

```yaml
# Too vague
description: Helps with projects.

# Missing triggers
description: Creates sophisticated multi-page documentation systems.

# Too technical, no user triggers
description: Implements the Project entity model with hierarchical relationships.
```

## Complete Example

```yaml
---
name: customer-onboarding
description: End-to-end customer onboarding workflow for PayFlow. Handles account creation, payment setup, and subscription management. Use when user says "onboard new customer", "set up subscription", or "create PayFlow account".
license: MIT
compatibility: Requires PayFlow MCP server connected
metadata:
  author: PayFlow Inc
  version: 2.1.0
  mcp-server: payflow
  category: workflow
  tags: [payments, onboarding, customers]
---
```
