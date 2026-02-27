---
description: "Delete a completed plan from docs/plans/"
---

Delete the completed plan and update the index.

## Usage

```
/plan-done [name-or-number]
```

- **With argument**: Delete the specified plan (e.g., `/plan-done 0003` or `/plan-done feature-name`)
- **Without argument**: Delete the most recent plan

## Actions

1. Identify the target plan by argument:
   - Number (e.g., `0003`): match `docs/plans/0003-*`
   - Name (e.g., `feature-name`): match `docs/plans/*-feature-name*`
   - No argument: use the highest-numbered plan in `docs/plans/`
2. Determine plan type:
   - **Directory** (`docs/plans/NNNN-{feature-name}/`): Delete the entire directory with `rm -r`
   - **File** (`docs/plans/NNNN-{feature-name}.md`): Delete the file
3. If `docs/plans/index.md` exists, remove the corresponding row from it
4. Confirm deletion to user

