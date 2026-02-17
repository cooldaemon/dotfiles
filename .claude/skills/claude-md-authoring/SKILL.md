---
name: claude-md-authoring
description: Guidelines for creating and maintaining CLAUDE.md files. Use when creating, updating, or reviewing CLAUDE.md documentation. Includes target file determination, templates, auto-load behavior, monorepo patterns, and best practices.
---

You are an expert at creating and maintaining CLAUDE.md files that effectively guide Claude Code in project-specific contexts.

# Purpose

This skill provides a complete framework for authoring CLAUDE.md files, including:
1. Determining which CLAUDE.md file to update (root vs subdirectory)
2. Templates and structural patterns
3. Best practices for content and formatting
4. Monorepo and multi-component project strategies

# Determining Target CLAUDE.md File

Before creating or updating content, determine which CLAUDE.md file should be the target.

## Working Directory Detection

Analyze the session to identify the primary working area:

1. **File Modification Analysis**
   - Count files modified per directory
   - Identify the directory with the most changes
   - Track nested component work (e.g., `packages/api/src/controllers/`)

2. **Command Execution Context**
   - Where were build/test commands run?
   - Were commands specific to a subdirectory?

3. **User Focus Indicators**
   - Explicit user statements ("update the API package")
   - File paths in discussions
   - Problem domains mentioned

4. **Scope Analysis**
   - Changes span multiple packages → likely root CLAUDE.md
   - Changes isolated to one component → likely subdirectory CLAUDE.md
   - Architectural decision affects all → root CLAUDE.md

## Content Classification Criteria

Use this decision matrix to classify session insights:

| Content Type | Examples | Target CLAUDE.md |
|--------------|----------|------------------|
| **Component-specific commands** | `npm run migrate`, `make build-api`, `pytest tests/api/` | Subdirectory |
| **Component-specific conventions** | "API routes must use async/await", "Frontend components use composition API" | Subdirectory |
| **Component-specific gotchas** | "PostgreSQL connections timeout after 30s", "React strict mode breaks this package" | Subdirectory |
| **Component architecture** | "API uses layered architecture", "Frontend state management with Pinia" | Subdirectory |
| **Component-specific testing** | "API tests require Docker", "Frontend uses Playwright" | Subdirectory |
| **Platform-specific (if per-package)** | "Windows: use WSL for API builds" | Subdirectory |
| **Shared conventions** | Commit message format, code review process, PR guidelines | Root |
| **Monorepo-wide commands** | `npm run build:all`, `make test-all`, workspace management | Root |
| **Project architecture** | Overall system design, service communication, shared infrastructure | Root |
| **Cross-cutting concerns** | Authentication strategy, logging approach, error handling patterns | Root |
| **Development environment** | IDE setup, linter configuration, formatter settings | Root |

## Decision Flow

Follow this systematic approach:

```
1. Identify primary working directory
   └─> Use file modification counts and command context

2. Classify content type
   └─> Use Content Classification Criteria table

3. Apply decision rules:

   IF content applies ONLY to identified directory:
       └─> Target: subdirectory CLAUDE.md

   ELSE IF content applies to multiple directories:
       └─> Target: root CLAUDE.md

   ELSE IF content is architectural/cross-cutting:
       └─> Target: root CLAUDE.md

   ELSE IF uncertain:
       └─> Ask user for clarification
```

## Edge Cases

**Multi-Directory Work Sessions:**
- Related components (e.g., `api/controllers/` and `api/models/`) → use parent directory CLAUDE.md
- Unrelated components → update root CLAUDE.md with cross-cutting insights
- Refactoring across areas → document in root CLAUDE.md

**Uncertain Classification:**
1. Ask the user: "Should this guidance apply only to [directory] or project-wide?"
2. Default to narrower scope (easier to move content up than down)
3. Consider where information would be most useful in future sessions

**Existing Subdirectory CLAUDE.md:**
1. Read it first to understand existing structure
2. Add new content to appropriate section
3. Avoid duplicating information from root CLAUDE.md
4. Maintain consistency with existing style

## Subdirectory CLAUDE.md Management

### When to Create

Create a new subdirectory CLAUDE.md when:

1. **Isolation Test**: Content is meaningful ONLY in that directory context
2. **Scope Test**: Information would clutter root CLAUDE.md
3. **Frequency Test**: Future sessions will work in this directory
4. **Ownership Test**: Directory has distinct conventions/workflows

### Subdirectory CLAUDE.md Template

Use this minimal template for new subdirectory CLAUDE.md files:

```markdown
# [Component Name]

[One-line description of this component's purpose]

## Commands

### Development
```bash
# Component-specific development commands
```

### Testing
```bash
# Component-specific test commands
```

## Architecture

### Component Structure
[Brief overview of how this component is organized]

### Key Technologies
- [Technology]: [Version and purpose]

## Important Notes

### Conventions
- [Component-specific conventions]

### Gotchas
- [Component-specific gotchas]
```

### Content Scope Rules

**Subdirectory CLAUDE.md should contain:**
- Commands run from this directory
- Conventions specific to this component
- Architecture of this component only
- Dependencies unique to this component
- Gotchas specific to this component

**Subdirectory CLAUDE.md should NOT contain:**
- General project conventions (belongs in root)
- Commands run from project root
- Cross-component architecture
- Shared dependencies
- Monorepo-wide workflows

## Targeting Examples

### Example 1: API Package Work

**Session Context:**
- 12 files modified in `packages/api/src/`
- Commands run: `npm run test:api`, `npm run migrate`
- Discussion: "API routes must handle timeouts gracefully"

**Decision:** Update `packages/api/CLAUDE.md`
- Primary directory: `packages/api/`
- Content type: Component-specific convention

### Example 2: Project-Wide Refactoring

**Session Context:**
- 5 files in `packages/api/`, 4 in `packages/frontend/`, 3 in `packages/shared/`
- Commands run: `npm run build:all`, `npm test`
- Discussion: "Moving to ESM modules across entire project"

**Decision:** Update root `CLAUDE.md`
- Primary directory: Multiple (distributed)
- Content type: Cross-cutting architectural change

### Example 3: Frontend Testing Setup

**Session Context:**
- 8 files in `packages/frontend/tests/`
- Commands run: `npm run test:frontend`, `npx playwright test`
- Discussion: "Playwright requires specific viewport settings"

**Decision:** Update `packages/frontend/CLAUDE.md`
- Primary directory: `packages/frontend/`
- Content type: Component-specific testing

### Example 4: Git Workflow Convention

**Session Context:**
- 1 file modified: `.github/pull_request_template.md`
- Discussion: "All PRs must include test evidence"

**Decision:** Update root `CLAUDE.md`
- Primary directory: Root (affects all packages)
- Content type: Shared convention

# Auto-Loaded Files

Claude Code automatically loads these files at startup:
- `CLAUDE.md` (project root)
- `CLAUDE.local.md` (gitignored, for personal preferences)
- `.claude/CLAUDE.md` (alternative location)
- `.claude/rules/*.md` (always loaded, global rules)

**Important**: Files with non-standard names like `CLAUDE-API.md` or `CLAUDE-FRONTEND.md` are NOT auto-loaded. Use subdirectory CLAUDE.md files or @import instead.

# CLAUDE.md vs .claude/ Directory

Understanding when to use CLAUDE.md files versus .claude/ directory components:

## CLAUDE.md Files

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

## .claude/ Directory

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

# Decision Flow

When adding component-specific instructions:

```
Need component-specific instructions?
    |
    +-- Simple instructions (conventions, commands, gotchas)
    |   --> Place CLAUDE.md in that directory (any level OK)
    |
    +-- Complex workflows or reusable logic
        --> Add to root .claude/ directory
            (use skills with `paths:` to limit scope)
```

# Monorepo Structure Pattern

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

# @import Syntax

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

# CLAUDE.md Template Structure

Use this template as a starting point:

```markdown
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

[Brief description of the project, its purpose, and main technologies]

## Commands

### Common Commands
```bash
# Development
[development commands]

# Testing
[test commands]

# Build
[build commands]

# Deployment
[deployment commands]
```

## Architecture

### Project Structure
```
project-root/
├── src/           # [Description]
├── tests/         # [Description]
├── docs/          # [Description]
└── ...
```

### Key Components
- **Component A**: [Description and location]
- **Component B**: [Description and location]

### Technology Stack
- **Language**: [Version and key configurations]
- **Framework**: [Version and important settings]
- **Database**: [Type and connection approach]
- **Dependencies**: [Key libraries and their purposes]

## Development Workflow

### Setup
1. [Step-by-step setup instructions]
2. [Environment configuration]
3. [Dependency installation]

### Coding Standards
- **Style Guide**: [Language-specific conventions]
- **Naming Conventions**: [Patterns for files, functions, variables]
- **Code Organization**: [Module structure, separation of concerns]
- **Documentation**: [Comment style, docstring format]

### Testing
- **Test Framework**: [Tool and configuration]
- **Test Structure**: [Organization and naming]
- **Coverage Requirements**: [Minimum coverage, excluded files]
- **Running Tests**: [Commands and options]

### Git Workflow
- **Branch Strategy**: [main/develop, feature branches, etc.]
- **Commit Convention**: [Semantic commits, conventional commits]
- **PR Process**: [Review requirements, CI checks]

## Important Notes

### Known Issues
- [Issue description and workaround]

### Performance Considerations
- [Optimization notes]
- [Resource constraints]

### Security
- [Security practices]
- [Sensitive data handling]

### Gotchas
- [Common pitfalls and how to avoid them]
- [Non-obvious behaviors]
- [Platform-specific issues]

## API Documentation

### Endpoints
- **GET /api/resource**: [Description]
- **POST /api/resource**: [Description]

### Authentication
- [Authentication method and implementation]

## Database Schema

### Main Tables
- **table_name**: [Purpose and key fields]

### Relationships
- [Important foreign keys and joins]

## Configuration

### Environment Variables
- `VAR_NAME`: [Purpose and format]

### Configuration Files
- **config.json**: [Purpose and structure]
- **settings.yml**: [Purpose and key settings]

## Deployment

### Environments
- **Development**: [URL and characteristics]
- **Staging**: [URL and characteristics]
- **Production**: [URL and characteristics]

### CI/CD Pipeline
- [Pipeline stages]
- [Deployment triggers]
- [Rollback procedure]

## Troubleshooting

### Common Errors
- **Error**: [Solution]

### Debugging Tips
- [Useful debugging commands]
- [Log locations]
- [Debug mode configuration]

## References

- [Link to detailed documentation]
- [Link to API docs]
- [Link to design documents]
```

# Writing Best Practices

## Content Guidelines

**Be Specific:**
- Include exact commands, file paths, version numbers
- Use concrete examples, not abstract descriptions
- Specify configurations and settings

**Be Concise:**
- Clear, direct language without unnecessary detail
- One topic per section
- Avoid redundant explanations

**Be Practical:**
- Focus on actionable information
- Include "how-to" not just "what"
- Provide context for decisions

**Be Current:**
- Update outdated information immediately
- Remove obsolete sections
- Mark deprecated features clearly

## Formatting Rules

- Use proper Markdown formatting
- Include code blocks with language hints
- Use consistent heading hierarchy (## for main sections, ### for subsections)
- Add comments to complex commands
- Use bullet points for lists
- Keep line length reasonable (80-100 chars for readability)

## Section Priority

Order sections by frequency of use:

1. **Commands**: Most frequently needed information
2. **Architecture**: Understanding the codebase
3. **Workflow**: How to work with the project
4. **Notes/Gotchas**: Avoiding common problems
5. **Other sections**: As relevant to the project

# Example Update Scenarios

## Scenario 1: New Testing Approach

```markdown
## Testing

### Unit Tests
- Framework: Jest with React Testing Library
- Run tests: `npm test`
- Watch mode: `npm test -- --watch`
- Coverage: `npm test -- --coverage`

**Important**: Mock API calls using MSW (Mock Service Worker) for consistent test behavior.
```

## Scenario 2: Discovered Gotcha

```markdown
## Important Notes

### Gotchas
- **Database Connections**: Always use connection pooling. Direct connections cause "too many connections" errors in production.
- **File Uploads**: Multipart form data must include `boundary` parameter. Use FormData API, not manual construction.
```

## Scenario 3: New Build Process

```markdown
## Commands

### Build
```bash
# Development build with hot reload
npm run dev

# Production build (optimized)
npm run build

# Build and analyze bundle size
npm run build:analyze
```
```

## Scenario 4: Monorepo Package-Specific Notes

**Root CLAUDE.md:**
```markdown
# CLAUDE.md

## Project Overview
This is a monorepo with API and Frontend packages.

## Common Commands
- `npm run build:all` - Build all packages
- `npm run test:all` - Test all packages
```

**packages/api/CLAUDE.md:**
```markdown
# API Package

## API-Specific Commands
- `npm run migrate` - Run database migrations
- `npm run seed` - Seed test data

## Gotchas
- Always run migrations before tests
```

# Large Projects Tips

For extensive documentation:
- Use clear section headers for navigation
- Include a table of contents for long files (use @import to modularize)
- Cross-reference related sections
- Consider subdirectory CLAUDE.md files for isolated components
- Use skills with `paths:` field for complex, scoped logic

# Anti-Patterns

**Do NOT:**
- Create files like `CLAUDE-API.md` or `CLAUDE-FRONTEND.md` (not auto-loaded)
- Place `.claude/` directories in subdirectories (ignored by Claude Code)
- Default to root CLAUDE.md without analyzing session context
- Add subdirectory-specific content to root CLAUDE.md
- Duplicate root CLAUDE.md content in subdirectories
- Create subdirectory CLAUDE.md for trivial or single-use information
- Mix component-specific and project-wide content in same file
- Include general programming knowledge (Claude already knows this)
- Write tutorials on basic syntax
- Copy documentation that exists elsewhere (use @import instead)
- Make sections too verbose (use references/ in skills for details)
- Use inconsistent heading levels
- Include sensitive information (API keys, passwords)

**DO:**
- Systematically analyze session context before choosing target file
- Use content classification criteria to determine target
- Ask user when uncertain about target file
- Use subdirectory CLAUDE.md files for component-specific guidance
- Keep subdirectory CLAUDE.md focused and minimal
- Use @import for modularizing single-project documentation
- Focus on project-specific conventions and decisions
- Keep commands and examples up-to-date
- Include "why" behind non-obvious decisions
- Cross-reference related sections
- Use code blocks with syntax highlighting
- Verify no duplicate information exists across CLAUDE.md files
