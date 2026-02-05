---
name: python-patterns
description: Python development patterns including flat layout project structure and uv package management.
---

# Python Development Patterns

## When to Activate

- Creating new Python projects
- Setting up Python packaging

## New Projects

- **Project structure**: Flat layout (package at repository root, no `src/` directory)
- **Package manager**: uv
- **Project initialization**: `uv init`

## Existing Projects

Respect the existing structure and tools:

- If using `src/` layout, keep it
- If using poetry/pipenv/pip, continue using them
- Match existing code style and patterns
