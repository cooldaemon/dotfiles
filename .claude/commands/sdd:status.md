---
name: sdd:status
description: Check the status of feature specifications using a subagent
---

Launch the sdd-status subagent to display comprehensive feature specification status.

## Usage
Check the status of features tracked in docs/plans/ with spec.json files.

## Arguments
- **No arguments**: Display status of all features
- **Feature name**: Display detailed status for specific feature

## Next Commands
Based on status, the subagent will suggest:
- `/create-requirements` - If requirements not generated
- `/create-design` - If design not generated
- `/create-tasks` - If tasks not generated
- `/implement-task` - If ready for implementation
- `/git-commit` - If all complete