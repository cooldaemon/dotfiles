---
description: "Create implementation plan for Claude Code configuration changes using PCOS team debate"
---

# Config Plan with PCOS Critical Review

Create a configuration change plan by orchestrating a PCOS Agent Team. Four teammates (Planner, Critic, Optimizer, Synthesizer) debate the plan before presenting it to the user.

## Execution Flow

1. **Gather context**: Collect the user's configuration change request (passed as $ARGUMENTS or from conversation context)
2. **Create Agent Team** (`pcos-config-plan`) with four teammates:
   - **planner** (agent: claude-config-planner, model: opus) — Drafts the plan
   - **critic** (agent: claude-config-critic, model: opus) — Finds problems
   - **optimizer** (agent: claude-config-optimizer, model: opus) — Proposes improvements
   - **synthesizer** (agent: claude-config-synthesizer, model: opus) — Converges debate, produces final output
3. **Create shared task**: "Create a config change plan for: [user's request]"
4. **Debate flow**:
   - Planner reads files, creates draft, sends to Critic and Optimizer
   - Critic sends challenges to Planner (copies Optimizer)
   - Optimizer sends improvement proposals to Planner
   - Planner responds to both, sends final version to Synthesizer
   - Critic and Optimizer send final assessments to Synthesizer
   - Synthesizer converges, resolves disagreements, produces final plan with Critique Log
5. **Synthesizer sends final output to team-lead**
6. **Team lead writes plan** to `docs/plans/NNNN-feature-name.md` and updates index
7. **Present to user**: Show the plan summary and critique highlights
8. **Shutdown team**

## Context for Teammates

Provide all teammates with:
- The user's configuration change request
- Instruction: "Do NOT read any files in `docs/plans/` directory"
- Any specific constraints or preferences mentioned by the user

## Debate Protocol

- Maximum 2 rounds of Critic-Planner exchange
- Critic focuses on PROBLEMS (what's wrong)
- Optimizer focuses on IMPROVEMENTS (what could be better) and DEADLOCK RESOLUTION (third-option alternatives)
- Synthesizer makes final evidence-based decisions on unresolved disagreements

## Prerequisites
- Clear understanding of the configuration change needed
- Access to .claude/ directory structure

## Next Commands
After user approves the plan:
- `/update-claude-config` - Execute the plan
