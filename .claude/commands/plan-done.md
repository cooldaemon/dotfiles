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

### Directory-based plans (ux.md + how.md)
1. Identify the target plan directory: `docs/plans/{feature-name}/`
2. Delete the entire directory: `rm -r docs/plans/{feature-name}/`
3. Confirm deletion to user

### Single-file plans (config plans)
1. Identify the target plan file: `docs/plans/NNNN-*.md`
2. Delete the file
3. Remove the corresponding row from `docs/plans/index.md`
4. Confirm deletion to user

## Next Commands

After deleting:
- `/commit` - Commit the plan deletion
