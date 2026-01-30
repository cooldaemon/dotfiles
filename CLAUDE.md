# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for automated macOS development environment setup using Ansible. It manages development tools, configurations, and settings for a consistent development environment.

## Commands

### Setup and Installation
```bash
# Initial setup for fresh macOS installation
make setup

# Update environment after changes
make update

# Run specific roles with make targets
make homebrew-update
make mise-update
make mcp-update
make vscode-update

# Show all available commands
make help

# Direct Ansible commands (if needed)
ansible-playbook -i localhost, -c local ansible/playbook.yml
ansible-playbook -i localhost, -c local ansible/playbook.yml --tags "homebrew,mise"
```


## Architecture

### Ansible-Based Configuration
The repository uses Ansible for automation with the following roles:
- **homebrew**: Installs command-line tools (fish, gpg, gawk, peco)
- **homebrew_cask**: Installs GUI applications (Docker, VS Code, Cursor, Dropbox, Google Drive)
- **mise**: Manages development languages (Node.js 20.18.2, Python 3.13.5, Ruby 3.3.4, Go 1.23.4) and global npm packages
- **vscode**: Configures VS Code and Cursor editors (disables Apple Press and Hold, creates settings.json symlinks)
- **fish**: Installs Oh My Fish framework and peco plugin
- **dotfiles**: Creates symlinks for configuration files and Claude settings
- **claude_mcp**: Configures Claude MCP (Model Context Protocol) servers (playwright, context7, peekaboo, serena)

Each role is tagged in the playbook for individual execution (e.g., `--tags homebrew`, `--tags mcp`)

### Key Configuration Files
- `.mise.toml`: Defines tool versions and global npm packages
- `.config/fish/`: Fish shell configurations
- `vscode/settings.json`: VS Code editor settings
- `cursor/settings.json`: Cursor editor settings with Copilot and Vim configurations
- `.claude/`: Claude Code settings and custom commands

### Claude Code Integration
The repository includes custom Claude commands in `.claude/commands/`:
- `git-commit.md`: Git commit helper
- `git-rebase-push.md`: Git rebase and push workflow
- `refactor.md`: Code refactoring guide
- `screenshot.md`: Screenshot handling
- `update-claude-md.md`: Updates project CLAUDE.md files

### Rules / Skills / Agents Design Principles

#### Rules (`.claude/rules/`)
- **Always loaded** - Keep lightweight to minimize context consumption
- **Principles only** - No implementation details
- **Language-agnostic** - Universal guidelines

#### Skills (`.claude/skills/`)
- **Conditionally loaded** - Auto-selected based on frontmatter `description`
- **Include implementation details** - Language/tool-specific patterns and code examples
- **Skip well-known APIs** - Don't create Skills for Playwright, Cypress alone (Claude knows these)
- **Focus on integrations** - e.g., Cucumber + Playwright combinations
- **Verify with context7** - Before writing library-specific code examples, verify against official docs

#### Agents (`.claude/agents/`)
- **Do NOT auto-inherit Skills/Rules** - Confirmed via official documentation
- **To use Skills**: Explicitly specify in frontmatter
  ```yaml
  skills:
    - cucumber-playwright
    - typescript-testing
  ```
- **Focus on workflow and decision criteria** - Omit implementation details defined in Skills

#### Sharing Content Between Main Session and Agents
- **Rules** are only loaded in the main session, not in agents
- **Skills** can be loaded in both (main via auto-detection, agents via explicit `skills:` field)
- **For content needed in both contexts**: Use Skills instead of Rules
  - Example: Testing principles (TDD, Test Pyramid) → Create `testing-principles` Skill
  - Main session: Auto-loads when working on tests
  - Agent: Loads via `skills: [testing-principles]` in frontmatter

## Development Workflow

1. All configuration changes should be made in the source dotfiles
2. Use Ansible playbook to apply changes (don't manually edit symlinked files)
3. The repository manages both development tools (via mise) and editor configurations
4. Claude Code settings are automatically symlinked from the repository

## Important Notes

- MCP servers are installed at user scope and managed by the `claude_mcp` Ansible role
- Use tags to run specific Ansible roles for faster updates during development
- **All generated files must be written in English** (code, comments, documentation, commit messages)