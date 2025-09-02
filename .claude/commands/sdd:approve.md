---
name: sdd:approve
description: Approve specification documents for SDD features
---

Launch the sdd-approve subagent to approve specification documents.

## Usage
Approve specification documents for features tracked in docs/specs/ with spec.json files.

## Arguments
- **Feature name**: The name of the feature to approve (required)
- **Document type**: Type of document to approve: requirements, design, tasks, or all (required)

## Examples
- `/sdd:approve sdd-command-refactoring requirements` - Approve requirements document only
- `/sdd:approve sdd-command-refactoring design` - Approve design document only
- `/sdd:approve sdd-command-refactoring tasks` - Approve tasks document only
- `/sdd:approve sdd-command-refactoring all` - Approve all generated documents

## Next Commands
After approval, the subagent will suggest:
- `/sdd:design` - If requirements approved but design not generated
- `/sdd:tasks` - If design approved but tasks not generated
- `/sdd:status` - To view updated approval status