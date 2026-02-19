# CLAUDE.md

## Repository Overview

This repository manages two things:

1. **Claude Code global configuration** — Rules, Skills, Agents, Commands, Hooks in `.claude/`, symlinked to `~/.claude/`. These apply to ALL projects on this machine.
2. **macOS development environment** — Ansible-based setup for tools, apps, and dotfiles.

## Commands

```bash
make setup              # Initial setup for fresh macOS
make update             # Update everything
make homebrew-update    # CLI tools only
make homebrew-cask-update
make mise-update        # Language versions and npm packages
make claude-update      # Claude Code installer
make mcp-update         # MCP servers
make dotfiles-update    # Symlinks
make gpg-setup
make help               # Show all targets
```

Direct Ansible: `ansible-playbook -i localhost, -c local ansible/playbook.yml --tags "homebrew,mise"`

## Architecture

### Ansible Roles
| Role | Purpose |
|------|---------|
| homebrew | CLI tools (fish, gpg, gawk, peco) |
| homebrew_cask | GUI apps (Docker, Dropbox, Google Drive, Zed, Karabiner, Session Manager Plugin) |
| mise | Languages (Node.js 20.18.2, Python 3.13.5, Ruby 3.3.4, Go 1.23.4), global npm |
| fish | Oh My Fish + peco plugin |
| dotfiles | Symlinks for config files and `.claude/` |
| claude_code | Claude Code native installer (auto-updates, removes legacy npm version) |
| claude_mcp | MCP servers (playwright, context7, peekaboo) |

Each role is tagged for individual execution (e.g., `--tags homebrew`, `--tags claude`)

### Key Files
- `.mise.toml` — Tool versions and global npm packages
- `.config/fish/` — Fish shell config
- `.claude/` — All Claude Code configuration (symlinked to `~/.claude/`)

## Design Principles

### Rules / Skills / Agents

| Layer | Location | Loading | Purpose |
|-------|----------|---------|---------|
| Rules | `.claude/rules/` | Always loaded (main session only) | Lightweight principles, language-agnostic |
| Skills | `.claude/skills/` | Conditionally loaded by description match | Principles and patterns (WHAT) |
| Agents | `.claude/agents/` | Invoked explicitly | Workflow and process (HOW) |

**Content placement rules:**
- Skills define principles. Agents define workflow. Never duplicate between them.
- Agents do NOT auto-inherit Rules or Skills — specify skills explicitly in frontmatter
- Content needed in both main session and agents → put in Skill (not Rule)
- When modifying an agent, check ALL skills it loads for consistency

### Agent Responsibility Boundaries

Parallel reviewers (launched by `/code-review`) have non-overlapping responsibilities:

| Agent | Scope |
|-------|-------|
| `code-reviewer` | Code quality: integrity, readability, performance, comments |
| `security-reviewer` | All security and OWASP concerns |
| `database-reviewer` | SQL queries, ORM usage, schema design |
| `dead-code-reviewer` | Unused code, imports, dependencies |

### Standard Workflow

```
/tdd → /git-commit (checkpoint) → /code-review → /tdd (fixes) → /git-commit
```

Commit before review creates a safe checkpoint for reverting bad fixes.

### TDD: AC-by-AC with Three-Layer Defense

```
For each AC: RED → GREEN (dummies OK) → REFACTOR (eliminate ALL dummies)
```

Quality defense layers:
1. **REFACTOR** (proactive) — tdd-guide eliminates dummies, applies coding-style
2. **coding-style checklist** (self-check) — Code Quality Checklist in the skill
3. **code-reviewer CRITICAL** (reactive) — catches anything that slipped through

## Editing This Repository

- Make changes in source files, then run `make dotfiles-update` (or `make update`)
- Do NOT manually edit symlinked files in `~/.claude/`
- MCP servers are managed by `claude_mcp` role, not manually
