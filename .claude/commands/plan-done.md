---
description: "Delete a completed plan from docs/plans/"
---

Delete the completed plan and update the index.

## Usage

```
/plan-done [NNNN]
```

- **With argument**: Delete the specified plan (e.g., `/plan-done 0003`)
- **Without argument**: Delete the most recent plan (highest number)

## Actions

1. Identify the target plan file
2. Delete `docs/plans/NNNN-*.md`
3. Remove the corresponding row from `docs/plans/index.md`
4. Confirm deletion to user

## Next Commands

After deleting:
- `/git-commit` - Commit the plan deletion
