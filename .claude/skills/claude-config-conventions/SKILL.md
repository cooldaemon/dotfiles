---
name: claude-config-conventions
description: "Conventions for Claude Code configuration files (agents, commands, rules, skills). Use when creating, reviewing, or modifying .claude/ configuration. Provides architecture principles, content placement rules, and agent responsibility boundaries."
---

# Claude Config Conventions

## Architecture Layers

| Layer | Location | Loading | Purpose |
|-------|----------|---------|---------|
| Rules | `.claude/rules/` | Always loaded (main session only) | Lightweight principles, language-agnostic |
| Skills | `.claude/skills/` | Conditionally loaded by description match | Principles and patterns (WHAT) |
| Agents | `.claude/agents/` | Invoked explicitly | Workflow and process (HOW) |

## Content Placement Rules

- Skills define principles (WHAT). Agents define workflow (HOW). Never duplicate between them.
- Agents do NOT auto-inherit Rules or Skills -- specify skills explicitly in frontmatter.
- Content needed in both main session and agents --> put in Skill (not Rule).
- When modifying an agent, check ALL skills it loads for consistency.

## Agent Conventions

**Frontmatter (required fields):**
- `name` -- kebab-case identifier
- `description` -- clear purpose and when to use
- `tools` -- list of required tools
- `skills` -- explicitly list all skills the agent needs (no auto-inheritance)

**`model:` field:**
- Optional. If omitted, inherits from caller.
- Plans must NOT specify model selection for agents they create -- model choice is the user's decision.
- Do not downgrade to cheaper models (sonnet, haiku) without explicit user instruction.

**Content rules:**
- Agent = workflow/process (HOW). Never duplicate content from skills it loads.
- Do not include general knowledge Claude already knows (standard library usage, basic syntax, general concepts).
- Include a "When Invoked" or startup section describing the execution flow.
- Include output format specification if the agent produces structured output.

## Command Conventions

**Frontmatter (required fields):**
- `description` -- concise, starts with a verb (used for matching/triggering)

**Content rules:**
- Body is expanded in the main session context (not inside a subagent).
- Should delegate to a subagent for actual work.
- Include a "Next Commands" section listing follow-up commands.
- Include a "Prerequisites" section if the command requires prior state.

## Rule Conventions

- Always loaded in main session only (not in agents).
- Lightweight principles, language-agnostic.
- Content needed in both main session and agents --> put in a Skill instead of a Rule.

## Agent Responsibility Boundaries

Reviewers have non-overlapping responsibilities:

| Agent | Scope |
|-------|-------|
| `code-reviewer` | Code quality: integrity, readability, performance, comments |
| `security-reviewer` | All security and OWASP concerns |
| `database-reviewer` | SQL queries, ORM usage, schema design |
| `dead-code-reviewer` | Unused code, imports, dependencies |
| `claude-config-reviewer` | Claude Code configuration quality and consistency |

## Anti-Patterns

- Putting workflow steps in a skill (belongs in agent)
- Putting shared principles in an agent (belongs in skill)
- Putting agent-needed content in a rule (rules are main-session only)
- Duplicating content between a skill and the agents that load it
- Downgrading model (sonnet, haiku) in plans or agent definitions without user instruction
- Omitting `skills:` from agent frontmatter when the agent needs shared principles
- Commands doing work directly instead of delegating to a subagent
