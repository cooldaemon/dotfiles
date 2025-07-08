# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for automated macOS development environment setup using Ansible. It manages development tools, configurations, and settings for a consistent development environment.

## Commands

### Setup and Installation
```bash
# Initial setup for fresh macOS installation
./setup.sh

# Update environment after changes
ansible-playbook -i localhost, -c local ansible/playbook.yml
```


## Architecture

### Ansible-Based Configuration
The repository uses Ansible for automation with the following roles:
- **homebrew**: Installs command-line tools (fish, gpg, gawk, peco)
- **homebrew_cask**: Installs GUI applications (Docker, VS Code, Cursor, Dropbox, Google Drive)
- **mise**: Manages development languages (Node.js 20.4.0, Python 3.13.5, Ruby 3.3.4, Go 1.23.4) and global npm packages
- **vscode**: Configures VS Code and Cursor editors (disables Apple Press and Hold, creates settings.json symlinks)
- **fish**: Installs Oh My Fish framework and peco plugin
- **dotfiles**: Creates symlinks for configuration files and Claude settings

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

## Development Workflow

1. All configuration changes should be made in the source dotfiles
2. Use Ansible playbook to apply changes (don't manually edit symlinked files)
3. The repository manages both development tools (via mise) and editor configurations
4. Claude Code settings are automatically symlinked from the repository