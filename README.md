# dotfiles

My personal dotfiles for macOS development environment setup.

## Features

- 🚀 Automated setup using Ansible
- 📦 Package management with Homebrew
- 🔧 Development tools version management with [mise](https://mise.jdx.dev/)
- 🐟 Fish shell configuration
- 🤖 AI development tools (Claude Code, MCP servers)

## Prerequisites

- macOS (tested on macOS 14.x)
- Git

## Quick Start

For a fresh macOS installation:

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Clone this repository
git clone https://github.com/[your-username]/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles

# 3. Run the setup script
./setup.sh

# 4. Change default shell to fish
chsh -s /opt/homebrew/bin/fish

# 5. Restart your terminal
```

## What Gets Installed

### Development Languages
- Node.js 20.4.0
- Python 3.13.5
- Ruby 3.3.4
- Go 1.23.4

### Global npm Packages
- [@anthropic-ai/claude-code](https://github.com/anthropics/claude-code) - AI code assistant
- [@playwright/mcp](https://github.com/microsoft/playwright) - Browser automation MCP server
- [@steipete/peekaboo-mcp](https://github.com/steipete/peekaboo-mcp) - Screen capture MCP server
- [@upstash/context7-mcp](https://github.com/upstash/context7) - Up-to-date documentation MCP server
- [aws-cdk](https://github.com/aws/aws-cdk) - AWS Cloud Development Kit

### Homebrew Packages
- fish (shell)
- gpg (encryption)
- gawk (text processing, required for Node.js)
- peco (interactive filtering)

### Homebrew Cask Applications
- Docker
- Visual Studio Code
- Dropbox
- Google Drive

## Directory Structure

```
.
├── .config/
│   └── fish/           # Fish shell configuration
├── ansible/
│   ├── playbook.yml    # Main Ansible playbook
│   └── roles/          # Ansible roles
│       ├── homebrew/   # Homebrew packages
│       ├── homebrew_cask/ # GUI applications
│       ├── mise/       # Development tools
│       └── dotfiles/   # Dotfiles linking
├── .gitconfig          # Git configuration
├── .gitignore_global   # Global gitignore
├── .mise.toml          # mise configuration
├── .tool-versions      # Tool versions (mise compatible)
└── setup.sh            # Main setup script
```

## Manual Steps After Installation

1. Configure Git with your information:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. Set up SSH keys for GitHub:
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   ```

## Updating

To update your environment:

```bash
cd ~/git/dotfiles
git pull
ansible-playbook -i localhost, -c local ansible/playbook.yml
```

## Troubleshooting

### Homebrew tap issues
If you encounter tap-related errors:
```bash
brew untap [problematic-tap]
```

### mise trust issues
If mise shows trust warnings:
```bash
mise trust ~/.mise.toml
```

## License

MIT