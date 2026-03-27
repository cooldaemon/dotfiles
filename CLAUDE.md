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

Task routing is auto-loaded from `.claude/rules/workflow.md`. Workflow sequences:

```
Code:   /plan-ux → /review-plan (optional) → /explore (optional) → /plan-how → /review-plan (optional) → /tdd or /tdd-team (experimental) → /push-to-remote
Config: /plan-claude-config → /review-plan (optional) → /update-claude-config → /push-to-remote
Bug:    /investigate → (branches to /plan-ux, /plan-how, or /tdd or /tdd-team)
```

Plans output to `docs/plans/NNNN-{feature-name}/`. Multiple USs can be developed before a single `/push-to-remote`.

## MCP Setup Guides

When `make mcp-update` skips a service due to missing credentials, refer to the appropriate setup guide:

- **Slack**: One-time app creation and token setup. See `docs/setup/slack-mcp.md`.
- **Confluence**: API token creation and registration. See `docs/setup/confluence-mcp.md`.

## Git Policy

- This repository operates on `master` only. Do NOT create branches without explicit user permission.

## Editing This Repository

- Make changes in source files, then run `make dotfiles-update` (or `make update`)
- Do NOT manually edit symlinked files in `~/.claude/`
- MCP servers are managed by `claude_mcp` role, not manually
