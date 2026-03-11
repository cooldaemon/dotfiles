# Advanced Patterns

Detailed documentation on auto-loaded files, CLAUDE.md vs .claude/ directory, monorepo patterns, and @import syntax.

## Auto-Loaded Files

Claude Code automatically loads these files at startup:
- `CLAUDE.md` (project root)
- `CLAUDE.local.md` (gitignored, for personal preferences)
- `.claude/CLAUDE.md` (alternative location)
- `.claude/rules/*.md` (always loaded, global rules)

**Important**: Files with non-standard names like `CLAUDE-API.md` or `CLAUDE-FRONTEND.md` are NOT auto-loaded. Use subdirectory CLAUDE.md files or @import instead.

## CLAUDE.md vs .claude/ Directory

Understanding when to use CLAUDE.md files versus .claude/ directory components:

### CLAUDE.md Files

**Placement:**
- Can be at ANY directory level (root, subdirectory, deeply nested)
- Loaded on-demand when Claude works in that directory
- Subdirectory files load in addition to root CLAUDE.md

**Best for:**
- Project conventions and coding standards
- Common commands and shortcuts
- Important gotchas and notes
- Directory-specific instructions
- Simple text-based guidance

**Example use cases:**
- `packages/api/CLAUDE.md` - API-specific conventions
- `src/components/CLAUDE.md` - Component structure rules
- `tests/e2e/CLAUDE.md` - E2E testing notes

### .claude/ Directory

**Placement:**
- ONLY recognized at project root or `~/.claude/`
- Subdirectory .claude/ directories are IGNORED (e.g., `packages/api/.claude/` won't work)

**Best for:**
- Complex workflows (agents)
- Reusable logic (skills)
- Slash commands
- Global rules (rules/)

**Monorepo scope control:**
Use `paths:` frontmatter in skills to limit scope:

```yaml
---
name: api-patterns
paths:
  - "packages/api/**"
---
```

## Decision Flow

When adding component-specific instructions:

```
Need component-specific instructions?
    |
    ├── Simple instructions (conventions, commands, gotchas)
    │   └── Place CLAUDE.md in that directory (any level OK)
    │
    └── Complex workflows or reusable logic
        └── Add to root .claude/ directory
            (use skills with `paths:` to limit scope)
```

## Monorepo Structure Pattern

Recommended structure for large projects or monorepos:

```
my-monorepo/
├── .claude/
│   ├── commands/
│   │   └── deploy.md           # Shared deploy command
│   └── skills/
│       ├── api-patterns/       # API development patterns
│       │   └── SKILL.md        # paths: ["packages/api/**"]
│       └── frontend-patterns/  # Frontend patterns
│           └── SKILL.md        # paths: ["packages/frontend/**"]
├── CLAUDE.md                   # Common rules (loaded at startup)
└── packages/
    ├── api/
    │   └── CLAUDE.md           # API-specific brief instructions
    └── frontend/
        └── CLAUDE.md           # Frontend-specific brief instructions
```

**Key points:**
- Root .claude/ for complex workflows and reusable components
- Use skills with `paths:` frontmatter to scope to specific directories
- Subdirectory CLAUDE.md files for simple, context-specific guidance
- Do NOT create `.claude/` directories in subdirectories (ignored by Claude Code)

## @import Syntax

For single projects that need modularization, use @import directives to pull in external documentation:

```markdown
# CLAUDE.md

@./docs/api-guidelines.md
@./docs/frontend-guidelines.md
@./docs/testing-guidelines.md

## Overview
Main project content here...
```

**How it works:**
- Imported files are merged into CLAUDE.md content at load time
- Use relative paths from CLAUDE.md location
- Useful for splitting large documentation without monorepo structure

**When to use:**
- Single project with extensive documentation
- Want to maintain documentation separately
- Need to share guidelines across projects
