# /checkpoint - Save Session State

Save important state before context compaction.

## When to Use

- Context feels low (approximately 50+ tool calls)
- Major feature or debugging completed
- Phase transition (exploration → implementation, implementation → testing)

## What to Do

1. **Create checkpoint file**
   - Path: `~/.claude/checkpoints/YYYY-MM-DD-HHMM.md`

2. **Record the following**:

```markdown
# Checkpoint: [Brief Description]
**Created:** YYYY-MM-DD HH:MM
**Project:** [Project Path]

## Completed
- [Completed tasks]

## In Progress
- [Current work]

## Next Steps
- [What to do next]

## Key Decisions
- [Important decisions made]

## Learnings
- [Discovered patterns/workarounds]

## Context to Load
- [File paths to read next session]
```

3. **CLAUDE.md Update Decision**
   - Project-specific important discoveries → Propose adding to CLAUDE.md
   - Temporary work state → Checkpoint file only

## Usage

```
/checkpoint
/checkpoint [name]
```

## Recovery After Compaction

1. Read checkpoint file: latest in `~/.claude/checkpoints/`
2. Load files listed in "Context to Load"
3. Resume from "Next Steps"
