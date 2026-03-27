---
description: "Create UX plan with user stories, ASCII art sketches, and Gherkin scenarios"
---

# UX Plan with PCOS Critical Review

Create a UX plan by orchestrating a PCOS Agent Team. Four teammates (Planner, Critic, Optimizer, Synthesizer) debate the plan before presenting it to the user.

## Complexity Gate

**Simple features** (1 user story, clear scope, no ambiguity): Delegate directly to `ux-planner` as a single subagent. Skip PCOS team debate.

**Complex features** (multiple user stories, ambiguous scope, UI trade-offs): Use full PCOS Agent Team below.

## Execution Flow

1. **Gather context**: Collect the user's feature request (passed as $ARGUMENTS or from conversation context)
2. **Assess complexity**: Determine if simple or complex (see Complexity Gate above)
3. **If simple**: Delegate to `ux-planner` subagent directly. The ux-planner drafts the plan. Then create `docs/plans/NNNN-{feature-name}/ux.md` and update index.
4. **If complex**: Create Agent Team (`pcos-ux-plan`) with four teammates:
   - **planner** (agent: ux-planner, model: opus) -- Drafts the UX plan
   - **critic** (agent: ux-critic, model: opus) -- Finds problems
   - **optimizer** (agent: ux-optimizer, model: opus) -- Proposes improvements
   - **synthesizer** (agent: ux-synthesizer, model: opus) -- Converges debate, writes plan file
5. **Create shared task**: "Create a UX plan for: [user's request]"
6. **Debate flow**:
   - Planner reads UI files, creates draft, sends to Critic and Optimizer
   - Critic sends challenges to Planner (copies Optimizer)
   - Optimizer waits for Critic's challenges, then sends proposals to Planner incorporating Critic's input
   - Planner responds to both, sends revised version to Critic, Optimizer, AND Synthesizer
   - Critic and Optimizer send final assessments to Synthesizer
   - Synthesizer converges, resolves disagreements, writes plan file, sends Critique Log to team-lead
7. **Present to user**: Show the plan summary and critique highlights
8. **Shutdown team**

## Context for Teammates

Provide all teammates with:
- The user's feature request
- Any specific constraints or preferences mentioned by the user

## Prerequisites
- Clear understanding of the feature request or user problem
- Access to relevant UI components (for modifications)

## Next Commands
After user approves ux.md:
- `/review-plan` (optional) - Cross-cutting review for assumptions, engineering calibration, coherence
- `/explore` - Explore target codebase (optional, recommended for unfamiliar codebases)
- `/plan-how` - Create implementation plan (Phase 2: HOW)
