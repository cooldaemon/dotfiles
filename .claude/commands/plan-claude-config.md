---
description: "Create implementation plan for Claude Code configuration changes using PCOS team debate"
---

# Config Plan with PCOS Critical Review

Create a configuration change plan by orchestrating a PCOS Agent Team. Four teammates (Planner, Critic, Optimizer, Synthesizer) debate the plan before presenting it to the user.

## Complexity Gate

**Simple changes** (single-file edit, mechanical update, no trade-offs): Delegate directly to `claude-config-planner` as a single subagent. Skip PCOS team debate.

**Complex changes** (multiple files, architectural trade-offs, new patterns): Use full PCOS Agent Team below.

## Execution Flow

1. **Gather context**: Collect the user's configuration change request (passed as $ARGUMENTS or from conversation context)
2. **Assess complexity**: Determine if simple or complex (see Complexity Gate above)
3. **If simple**: Delegate to `claude-config-planner` subagent directly. The planner drafts and writes the plan file.
4. **If complex**: Create Agent Team (`pcos-config-plan`) with four teammates:
   - **planner** (agent: claude-config-planner, model: opus) -- Drafts the plan
   - **critic** (agent: claude-config-critic, model: opus) -- Finds problems
   - **optimizer** (agent: claude-config-optimizer, model: opus) -- Proposes improvements
   - **synthesizer** (agent: claude-config-synthesizer, model: opus) -- Converges debate, writes plan file
5. **Create shared task**: "Create a config change plan for: [user's request]"
6. **Debate flow**:
   - Planner reads files, creates draft, sends to Critic and Optimizer
   - Critic sends challenges to Planner (copies Optimizer)
   - Optimizer waits for Critic's challenges, then sends proposals to Planner incorporating Critic's input
   - Planner responds to both, sends revised version to Critic, Optimizer, AND Synthesizer
   - Critic and Optimizer send final assessments to Synthesizer
   - Synthesizer converges, resolves disagreements, writes plan file, sends Critique Log to team-lead
7. **Present to user**: Show the plan summary and critique highlights
8. **Shutdown team**

## Context for Teammates

Provide all teammates with:
- The user's configuration change request
- Any specific constraints or preferences mentioned by the user

## Prerequisites
- Clear understanding of the configuration change needed
- Access to .claude/ directory structure

## Next Commands
After user approves the plan:
- `/review-plan` (optional) - Cross-cutting review for assumptions, engineering calibration, coherence
- `/update-claude-config` - Execute the plan
