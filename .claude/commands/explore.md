---
description: "Deep multi-agent codebase exploration to inform implementation planning"
---

# Codebase Exploration

Explore the target project's codebase to build deep understanding before implementation planning. Ported from feature-dev plugin Phase 2.

## Design Note

This command runs in the main session (not delegated to a subagent) because it must launch multiple agents in parallel via the Agent tool, which is only available to the main session.

## Execution Flow

1. **Find plan directory**: Locate `docs/plans/NNNN-{feature-name}/ux.md` (most recent, or user-specified)
2. **Read ux.md**: Extract user stories, feature scope, and technical context
3. **Launch 2-3 codebase-explorer agents in parallel**: Each agent should:
   - Trace through the code comprehensively and focus on getting a comprehensive understanding of abstractions, architecture and flow of control
   - Target a different aspect of the codebase
   - Include a list of 5-10 key files to read

   **Example agent prompts** (adapt to the specific feature from ux.md):
   - "Find features similar to [feature] and trace through their implementation comprehensively"
   - "Map the architecture and abstractions for [feature area], tracing through the code comprehensively"
   - "Analyze the current implementation of [existing feature/area], tracing through the code comprehensively"
   - "Identify UI patterns, testing approaches, or extension points relevant to [feature]"

   Use the Agent tool with `subagent_type: "codebase-explorer"` for each agent.

4. **Read key files**: Once agents return, read all files identified by agents to build deep understanding
5. **Write explore.md**: Consolidate agents' findings + key file reads into `docs/plans/NNNN-{feature-name}/explore.md`. Present comprehensive summary of findings and patterns discovered.
6. **Present summary**: Show the user a concise overview of findings

## Prerequisites
- UX plan exists at `docs/plans/NNNN-{feature-name}/ux.md` (created via `/plan-ux`)

## Next Commands
After exploration:
- `/plan-how` - Create implementation plan (enriched by explore.md)
