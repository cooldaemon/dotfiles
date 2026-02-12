---
name: skill-development
description: Guidelines for creating Claude Code skills. Use when creating new skills, reviewing skill structure, or improving existing skills. Based on Anthropic's official skill development guide.
---

# Skill Development Guidelines

## Before You Start

Define 2-3 concrete use cases before writing:
1. What does a user want to accomplish?
2. What multi-step workflows does this require?
3. What domain knowledge should be embedded?

### Skill Categories

| Category | Use Case | Key Techniques |
|----------|----------|----------------|
| Document & Asset Creation | Consistent output (docs, code, designs) | Templates, style guides, quality checklists |
| Workflow Automation | Multi-step processes | Step ordering, validation gates, iterative loops |
| MCP Enhancement | Workflow guidance for tools | Coordinates MCP calls, embeds domain expertise |

## Folder Structure

```
skill-name/           # kebab-case required
├── SKILL.md          # Required (uppercase, exact)
├── references/       # Detailed docs (on-demand loading)
├── scripts/          # Executable scripts
└── assets/           # Templates, fonts, icons
```

**Critical Rules**:
- SKILL.md must be exactly `SKILL.md` (case-sensitive)
- Folder name: kebab-case, no spaces, no capitals
- NO README.md inside skill folder (use references/)

## YAML Frontmatter

### Required Fields

```yaml
---
name: skill-name      # kebab-case, matches folder
description: "..."    # Controls when skill triggers
---
```

### Optional Fields

```yaml
license: MIT
compatibility: Requires Python 3.10+
metadata:
  author: Your Name
  version: 1.0.0
  mcp-server: server-name
```

See `references/yaml-reference.md` for complete field documentation.

### Security Restrictions

**Forbidden in frontmatter**:
- XML angle brackets (< >) - injection risk
- "claude" or "anthropic" in name (reserved)

## Description Field (CRITICAL)

Structure: `[What it does] + [When to use it] + [Key capabilities]`

```yaml
# BAD: Too vague
description: "Creates documents"

# BAD: Missing triggers
description: "Sophisticated multi-page documentation systems"

# GOOD: Complete formula
description: "Creates Word documents with tracked changes for legal review. Use when user asks for contracts, legal documents, or revision-tracked content."

# GOOD: With negative trigger
description: "Advanced data analysis for CSV files. Use for statistical modeling, regression. Do NOT use for simple data exploration."
```

Include:
- What the skill does
- Trigger phrases/scenarios (what users actually say)
- File types if relevant
- Negative triggers when needed (Do NOT use for...)

## Content Guidelines

### DO Include

- **Policies/directions**: What to do, what approach to take
- **Anti-patterns**: What to avoid
- **Domain knowledge**: Information requiring lookup
- **Output formats**: Expected structure when not obvious

### DO NOT Include

- Standard library commands (Claude knows these)
- Basic language syntax
- General programming concepts
- Things you could find in any tutorial

### Example

```markdown
# BAD: Explaining what Claude knows
## How to use pytest
Run `pytest` to execute tests. Use `-v` for verbose.

# GOOD: Policy only
## Testing Policy
- Use pytest with fixtures in conftest.py
- Prefer parametrize over duplicate tests
- Coverage target: 80% for business logic
```

## Progressive Disclosure

Skills load in three levels to save context:

| Level | Content | Loaded When |
|-------|---------|-------------|
| 1 | Name + description | Always (~100 tokens) |
| 2 | Full SKILL.md | Skill triggered |
| 3 | references/, scripts/ | On demand |

**Front-load important rules** - Claude pays more attention to content at the top.

## Size Guidelines

| Component | Guideline |
|-----------|-----------|
| SKILL.md | Under 500 lines, ~5000 words |
| Detailed docs | Move to references/ |
| Large examples | Move to references/ or scripts/ |

## Testing Your Skill

### Trigger Tests

Should trigger on:
- Obvious requests
- Paraphrased requests

Should NOT trigger on:
- Unrelated topics
- Similar but different domains

**Debug**: Ask Claude "When would you use [skill-name]?" - it quotes the description.

### Functional Tests

- Valid outputs generated
- Expected workflow followed
- Error handling works

### Iteration Signals

| Signal | Meaning | Fix |
|--------|---------|-----|
| Never triggers | Description too vague | Add specific phrases |
| Triggers for unrelated | Description too broad | Add negative triggers |
| Wrong behavior | Instructions unclear | Add explicit steps |

See `references/troubleshooting.md` for common issues.

## Checklist

### Before Creating
- [ ] Identified 2-3 concrete use cases
- [ ] Is this knowledge Claude doesn't have?
- [ ] Would I explain this repeatedly without a skill?

### During Development
- [ ] Folder name in kebab-case
- [ ] SKILL.md exists (exact spelling)
- [ ] Frontmatter has `---` delimiters
- [ ] Name field: kebab-case, no spaces
- [ ] Description includes WHAT and WHEN
- [ ] No XML tags anywhere
- [ ] Under 500 lines
- [ ] Anti-patterns included
- [ ] Library-specific examples verified

### Before Release
- [ ] Tested triggering on obvious tasks
- [ ] Tested triggering on paraphrased requests
- [ ] Verified doesn't trigger on unrelated topics
- [ ] Functional tests pass

## References

- `references/yaml-reference.md` - Complete YAML field documentation
- `references/workflow-patterns.md` - 5 common skill patterns
- `references/troubleshooting.md` - Common issues and solutions
