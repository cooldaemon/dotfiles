---
name: python-patterns
description: Python development patterns including package manager detection (uv, poetry, pip), project structure, and idiomatic Python practices.
---

# Python Development Patterns

## Package Manager Detection (CRITICAL)

**Before running ANY Python commands, detect the package manager:**

| File | Package Manager | Prefix |
|------|-----------------|--------|
| `uv.lock` | uv | `uv run` |
| `poetry.lock` | poetry | `poetry run` |
| `Pipfile.lock` | pipenv | `pipenv run` |
| None | pip | `python -m` |

**NEVER use `pip install` directly when lock file exists.**

## Project Structure

```
project/
├── mypackage/          # NOT src/mypackage/
│   └── ...
├── tests/
├── pyproject.toml
├── uv.lock
└── Makefile
```

Flat layout (`mypackage/`) is preferred over src layout (`src/mypackage/`).
