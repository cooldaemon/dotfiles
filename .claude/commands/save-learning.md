---
description: "Capture a learning note from the current conversation context"
---

# Save Learning

Save a learning note to `docs/learn/` in the current project repo. This command runs interactively in the main session (no subagent needed).

## Execution Flow

1. **Summarize context**: Based on the current conversation, draft a learning note with:
   - **Topic**: A short kebab-case identifier (e.g., `pcos-porting-fidelity`, `skill-description-matching`)
   - **Context**: What was happening (plan, task, conversation)
   - **What happened**: Factual description of the event
   - **What was learned**: The takeaway -- actionable knowledge for future work
   - **Tags**: 1-3 keywords for retrieval (e.g., `pcos`, `porting`, `agent-design`)
2. **Confirm with user**: Show the draft and ask for confirmation or refinements
3. **Save**: Create `docs/learn/` directory if it does not exist. If newly created, add `docs/learn/` to the project's `.gitignore`. Then write to `docs/learn/{topic}.md`

## Learning Note Format

The file uses this template:

    ---
    tags: [tag1, tag2]
    date: YYYY-MM-DD
    ---

    # {Title}

    **Context**: {what was happening}

    ## What Happened

    {Factual description}

    ## What Was Learned

    {Actionable takeaway}
