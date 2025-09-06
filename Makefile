.PHONY: all setup brew ansible fish playbook

# Default target
all: setup

# Full setup process
setup: brew ansible playbook fish
	@echo "Setup complete!"

# Install Homebrew if not present
brew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; \
	else \
		echo "Homebrew is already installed"; \
	fi
	@eval "$$(/opt/homebrew/bin/brew shellenv)"

# Install Ansible if not present
ansible: brew
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	if ! command -v ansible >/dev/null 2>&1; then \
		echo "Installing Ansible..."; \
		brew install ansible; \
	else \
		echo "Ansible is already installed"; \
	fi

# Run Ansible playbook
playbook: ansible
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml

# Add fish to /etc/shells if not present
fish:
	@if ! grep -q "^/opt/homebrew/bin/fish$$" /etc/shells; then \
		echo "Adding fish to /etc/shells..."; \
		echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells; \
	else \
		echo "Fish is already in /etc/shells"; \
	fi

# Additional useful targets
update: playbook
	@echo "Environment updated!"

# Run specific Ansible tags
homebrew-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags homebrew

homebrew-cask-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags homebrew_cask

mise-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags mise

mcp-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags mcp

vscode-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags vscode

dotfiles-update:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags dotfiles

gpg-setup:
	@eval "$$(/opt/homebrew/bin/brew shellenv)" && \
	ansible-playbook -i localhost, -c local ansible/playbook.yml --tags gpg

# Help target
help:
	@echo "Available targets:"
	@echo "  make setup          - Full initial setup (installs brew, ansible, runs playbook, configures fish)"
	@echo "  make update         - Run ansible playbook to update environment"
	@echo "  make homebrew-update - Update only homebrew packages"
	@echo "  make homebrew-cask-update - Update only homebrew cask applications"
	@echo "  make mise-update    - Update only mise tools"
	@echo "  make mcp-update     - Update only MCP servers"
	@echo "  make vscode-update  - Update only VS Code/Cursor settings"
	@echo "  make dotfiles-update - Update only dotfiles symlinks"
	@echo "  make gpg-setup      - Setup GPG keys for Git commit signing"
	@echo "  make help           - Show this help message"