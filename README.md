# dotfiles

My personal dotfiles for macOS development environment setup.

## Prerequisites

- macOS
- Git
- Xcode Command Line Tools (`xcode-select --install`)

## Quick Start

```bash
git clone git@github.com:cooldaemon/dotfiles.git
cd dotfiles
make setup
chsh -s /opt/homebrew/bin/fish
```

Restart your terminal after setup.

## Updating

```bash
cd ~/git/dotfiles
git pull
make update
```

Run `make help` to see all available targets.

## What It Does

- Installs CLI tools and GUI applications via Homebrew
- Manages development language versions via [mise](https://mise.jdx.dev/)
- Configures Fish shell with Oh My Fish
- Sets up Claude Code and MCP servers
- Symlinks dotfiles and configuration files

See `Makefile` and `ansible/` for details.

## Manual Steps After Installation

1. Configure Git:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. Set up SSH keys:
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   ```

## License

MIT
