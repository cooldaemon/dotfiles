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
| homebrew | CLI tools (fish, gpg, gawk, peco, peekaboo) |
| homebrew_cask | GUI apps (Docker, Dropbox, Google Drive, Zed, Karabiner, Session Manager Plugin) |
| mise | Languages (Node.js 20.18.2, Python 3.13.5, Ruby 3.3.4, Go 1.23.4), global npm |
| fish | Oh My Fish + peco plugin |
| dotfiles | Symlinks for config files and `.claude/` |
| claude_code | Claude Code native installer (auto-updates, removes legacy npm version) |
| claude_mcp | MCP servers (playwright, context7, slack, confluence) |

Each role is tagged for individual execution (e.g., `--tags homebrew`, `--tags claude`)

### Key Files
- `.mise.toml` — Tool versions and global npm packages
- `.config/fish/` — Fish shell config
- `.claude/` — All Claude Code configuration (symlinked to `~/.claude/`)

## Standard Workflow

### Code Changes
```
/plan-ux → /plan-how → /create-architecture-decision (if ADR candidates) → /tdd (US-level, git fixup, auto-review) → /tdd (fixes, if review issues) → /push-to-remote
```

### Config Changes
```
/plan-claude-config (PCOS debate) → /update-claude-config (auto-reviews, git commit) → /update-claude-config (git fixup, if review issues) → /push-to-remote
```

### Bug Investigation
```
/investigate → (branch to /plan-ux, /plan-how, or /tdd based on findings)
```

### Two-Phase Planning (Code)

| Phase | Command | Agent Team (PCOS) | Output |
|-------|---------|-------------------|--------|
| Phase 1: WHAT | `/plan-ux` | ux-planner, ux-critic, ux-optimizer, ux-synthesizer | `docs/plans/NNNN-{feature-name}/ux.md` |
| Phase 2: HOW | `/plan-how` | how-planner, how-critic, how-optimizer, how-synthesizer | `docs/plans/NNNN-{feature-name}/how.md` |
| Phase 2.5: ADR | `/create-architecture-decision` | adr-architect | `docs/adr/NNNN-title.md` (if candidates) |

All PCOS-enabled commands include a complexity gate: simple requests bypass team debate.

Multiple USs can be developed and reviewed before a single `/push-to-remote`.

### TDD: US-by-US with Three-Layer Defense

```
For each US: RED → GREEN (dummies OK) → git commit → REFACTOR (eliminate ALL dummies) → git fixup
```

Quality defense layers (all run within a single `/tdd` invocation per US):
1. **REFACTOR** (proactive) — tdd-guide eliminates dummies, applies coding-style
2. **coding-style checklist** (self-check) — Code Quality Checklist in the skill
3. **code-reviewer CRITICAL** (reactive) — auto-runs after US completion, catches anything that slipped through

## MCP Setup Guides

When `make mcp-update` skips a service due to missing credentials, refer to the appropriate setup guide:

- **Slack**: One-time app creation and token setup. See `docs/setup/slack-mcp.md`.
- **Confluence**: API token creation and registration. See `docs/setup/confluence-mcp.md`.

## Editing This Repository

- Make changes in source files, then run `make dotfiles-update` (or `make update`)
- Do NOT manually edit symlinked files in `~/.claude/`
- MCP servers are managed by `claude_mcp` role, not manually
