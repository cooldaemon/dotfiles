# Repository Guidelines

## Project Structure & Module Organization
This repository provisions a macOS development environment via Ansible. Core automation lives in `ansible/playbook.yml`, which chains roles in `ansible/roles/` such as `homebrew`, `homebrew_cask`, `mise`, `dotfiles`, `claude_mcp`, `gpg`, and `fish`. Dotfiles reside in `.config/`, `.claude/`, `.tmux.conf`, and `.gitconfig`, and are symlinked by the dotfiles role. Global tool versions are pinned in `.mise.toml` and `.tool-versions`. The root `Makefile` is the entry point for setup targets, while `.claude/agents` and `.claude/commands` provide MCP assets consumed by Claude tooling.

## Build, Test, and Development Commands
Run `make setup` for the full bootstrap (installs Homebrew, Ansible, runs the playbook, adds fish to `/etc/shells`). Use `make update` to re-run the playbook against an existing system. To scope work, call targets like `make homebrew-update` or `make dotfiles-update`. During development, prefer `ansible-playbook -i localhost, -c local ansible/playbook.yml --check` for dry runs and `ansible-playbook ... --tags <role>` to iterate on a single component. `make help` lists all supported targets.

## Coding Style & Naming Conventions
Author Ansible YAML with two-space indentation, lists aligned beneath their keys, and descriptive `name` fields written in imperative mood. Variables stay `snake_case`, and Jinja templates (`{{ variable }}`) are double-quoted to avoid type ambiguity. Use idempotent modules whenever possible; resort to `shell` only when there is no module alternative. Prefer keeping dotfiles declarative—new files should live under `.config/` or `.claude/` and be managed by the `dotfiles` role.

## Testing Guidelines
Every change should pass `ansible-playbook ... --syntax-check` before review. Validate idempotence by running the target role twice (e.g., `ansible-playbook ... --tags mise --check` followed by the same command without `--check`). When adding tooling, confirm `make <target>` exits cleanly on macOS 14.x, and document any prerequisites not already satisfied by Homebrew.

## Commit & Pull Request Guidelines
Follow Conventional Commits, mirroring scopes seen in history (`feat(homebrew)`, `refactor(claude)`, `fix(fish)`). Keep subject lines <=72 characters and describe config deltas in the body. Pull requests should include: a short summary of the environment change, the exact `make`/`ansible` commands run (with `--check` results), and any follow-up manual steps for contributors. Add screenshots only when UI-facing tooling is touched.
