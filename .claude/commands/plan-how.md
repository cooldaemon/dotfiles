---
description: "Create implementation plan with EARS system behavior"
---

# Implementation Plan with PCOS Critical Review

Create an implementation plan by orchestrating a PCOS Agent Team. Four teammates (Planner, Critic, Optimizer, Synthesizer) debate the plan before presenting it to the user. ADR candidates are identified by the Optimizer and integrated by the Synthesizer.

## Complexity Gate

**Simple features** (1 user story, straightforward implementation, no architecture trade-offs): Delegate directly to `how-planner` as a single subagent. Skip PCOS team debate.

**Complex features** (multiple user stories, architecture decisions, trade-offs): Use full PCOS Agent Team below.

## Execution Flow

1. **Read ux.md**: Find and read `docs/plans/NNNN-{feature-name}/ux.md`
2. **Assess complexity**: Determine if simple or complex (see Complexity Gate above)
3. **If simple**: Delegate to `how-planner` subagent directly. Provide ux.md content. Then write `how.md` to the same feature directory.
4. **If complex**: Create Agent Team (`pcos-how-plan`) with four teammates:
   - **planner** (agent: how-planner, model: opus) -- Drafts the implementation plan
   - **critic** (agent: how-critic, model: opus) -- Finds problems
   - **optimizer** (agent: how-optimizer, model: opus) -- Proposes improvements, identifies ADR candidates
   - **synthesizer** (agent: how-synthesizer, model: opus) -- Converges debate, writes plan and ADR files
5. **Create shared task**: Include the following context:
   - "Create an implementation plan for: [feature name]"
   - `## UX Plan (ux.md)` followed by the full ux.md content
6. **Debate flow**:
   - Planner reads codebase, creates draft, sends to Critic and Optimizer
   - Critic sends challenges to Planner (copies Optimizer)
   - Optimizer waits for Critic's challenges, then sends proposals (including ADR candidate suggestions) to Planner incorporating Critic's input
   - Planner responds to both, sends revised version to Critic, Optimizer, AND Synthesizer
   - Critic and Optimizer send final assessments to Synthesizer
   - Synthesizer converges, resolves disagreements, writes how.md (and ADR files if identified), sends Critique Log to team-lead
7. **Present to user**: Show the plan summary and critique highlights
8. **Shutdown team**

## Context for Teammates

Provide all teammates with:
- The feature name and request context
- The full ux.md content prefixed with `## UX Plan (ux.md)`
- Any specific constraints or preferences mentioned by the user

## Prerequisites
- UX plan exists at `docs/plans/NNNN-{feature-name}/ux.md` (created via `/plan-ux`)
- User has approved the UX plan

## Next Commands
After user approves how.md:
- `/review-plan` (optional) - Cross-cutting review for assumptions, engineering calibration, coherence
- `/tdd` - Implement with test-driven development
