---
name: skill-development
description: Guidelines for creating Claude Code skills. Use when creating new skills, reviewing skill structure, or improving existing skills.
---

# Skill Development Guidelines

## Folder Structure

```
skill-name/           # kebab-case required
├── SKILL.md          # Required (uppercase)
├── references/       # Detailed docs (optional)
├── examples/         # Working examples (optional)
└── scripts/          # Executable scripts (optional)
```

## SKILL.md Structure

```yaml
---
name: skill-name      # kebab-case, matches folder name
description: "..."    # CRITICAL: Controls when skill triggers
---

# Skill Title

## Content here
```

## Description Field (CRITICAL)

The description determines when the skill activates. Be specific.

```yaml
# BAD: Too vague, won't trigger reliably
description: "Creates documents"

# GOOD: Clear trigger conditions
description: "Creates Word documents with tracked changes for legal review. Use when user asks for contracts, legal documents, or revision-tracked content."
```

Include:
- What the skill does
- Trigger phrases/scenarios
- Use cases

## Content Guidelines

### DO Include

- **Policies/directions**: What to do, what approach to take
- **Anti-patterns**: What to avoid
- **Domain knowledge**: Information requiring context7 or web search
- **Output formats**: Expected structure when not obvious

### DO NOT Include

- Standard library commands (Claude knows these)
- Basic language syntax
- General programming concepts
- Things you could find in any tutorial

### Example

```markdown
# BAD: Explaining what Claude already knows
## How to use pytest
Run `pytest` to execute tests. Use `-v` for verbose output.

# GOOD: Policy/direction only
## Testing Policy
- Use pytest with fixtures in conftest.py
- Prefer parametrize over duplicate tests
- Coverage target: 80% for business logic
```

## Size Guidelines

| Component | Guideline |
|-----------|-----------|
| SKILL.md | Under 500 lines |
| Detailed docs | Move to references/ |
| Large examples | Move to examples/ |

## Progressive Disclosure

Skills load in levels to save context:
1. **Level 1**: Name + description (always loaded, ~100 tokens)
2. **Level 2**: Full SKILL.md (loaded when triggered)
3. **Level 3**: references/, scripts/, assets/ (loaded on demand)

Front-load important rules. Claude pays more attention to content at the top.

## Verification with context7

Before writing library-specific code examples, verify against official docs using context7.

```
1. resolve-library-id → Find library ID
2. query-docs → Verify patterns/APIs
3. Only then write examples
```

Skip verification for well-established, stable APIs (basic JavaScript, SQL, HTTP).

## Checklist Before Creating

- [ ] Is this knowledge Claude doesn't have?
- [ ] Would I explain this repeatedly without a skill?
- [ ] Is the description specific enough to trigger correctly?
- [ ] Is SKILL.md under 500 lines?
- [ ] Are anti-patterns included?
- [ ] Library-specific examples verified with context7?
