---
name: sdd:cleanup
description: Manage completed specification documents through archive, delete, and status operations
---

Launch the sdd-cleanup subagent to handle cleanup operations on completed specification documents.

## Usage

Manage completed specifications in docs/specs/ through various cleanup operations.

## Operations

### Archive Operation
Archive completed specs to docs/specs-archive/ with timestamp-based organization:

```bash
/sdd:cleanup archive <feature-name>     # Archive specific feature
/sdd:cleanup archive --all              # Archive all completed specs
/sdd:cleanup archive --dry-run          # Preview archive operation
```

### Delete Operation
Permanently delete completed specs with safety confirmations:

```bash
/sdd:cleanup delete <feature-name>      # Delete specific feature
/sdd:cleanup delete --all               # Delete all completed specs
/sdd:cleanup delete --force             # Skip confirmation prompts
/sdd:cleanup delete --dry-run           # Preview delete operation
```

### Status Operation
Check implementation status and cleanup eligibility:

```bash
/sdd:cleanup status                     # Show all specs status
/sdd:cleanup status <feature-name>      # Show specific feature status
/sdd:cleanup status --completed-only    # Show only completed specs
```

### Restore Operation
Restore archived specs back to active workspace:

```bash
/sdd:cleanup restore <feature-name>     # Restore specific archived feature
/sdd:cleanup restore --list             # List available archived specs
```

## Arguments

### Target Specifications
- **`<feature-name>`**: Operate on specific feature (e.g., `user-authentication`)
- **`--all`**: Apply operation to all eligible specifications
- **`--completed-only`**: Filter to only completed specifications

### Operation Modes
- **`--dry-run`**: Preview operation without making changes
- **`--force`**: Skip confirmation prompts (use with caution)
- **`--auto-confirm`**: Auto-confirm with brief timeout
- **`--list`**: List available specs or archives

### Selection Criteria
- **`--criteria completed`**: Only specs with implementation status "completed"
- **`--criteria verified`**: Only specs that have passed verification
- **`--criteria older-than=30d`**: Only specs older than specified duration

## Examples

```bash
# Check status of all specifications
/sdd:cleanup status

# Preview archiving all completed specs
/sdd:cleanup archive --all --dry-run

# Archive a specific completed feature
/sdd:cleanup archive user-authentication

# Delete old completed specs with confirmation
/sdd:cleanup delete --criteria "older-than=60d"

# List what can be restored from archive
/sdd:cleanup restore --list

# Restore a previously archived feature
/sdd:cleanup restore user-authentication
```

## Safety Features

- **Completion Validation**: Verifies specs are truly complete before cleanup
- **Git Status Checks**: Warns about uncommitted changes
- **Confirmation Prompts**: Multi-level confirmations for destructive operations
- **Dry-run Mode**: Preview all operations before execution
- **Archive Option**: Offers archiving as alternative to deletion
- **Restore Capability**: Full restore functionality for archived specs

## Next Commands

Based on cleanup results, the subagent will suggest:
- `/sdd:status` - Check overall project status after cleanup
- `/git-commit` - Commit cleanup changes
- Additional cleanup operations if more specs are eligible