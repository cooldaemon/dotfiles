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

## Naming Conventions

**Agent naming: `{scope}-{role}`**
- `{scope}` matches the command's `{object}` keyword for discoverability
- `{role}` conveys the agent's persona (designer, planner, reviewer, etc.)
- Examples: `ux-designer`, `how-planner`, `adr-architect`, `build-fixer`, `code-reviewer`

**Command naming: `{verb}-{object}`**
- Verb-first for action clarity
- Examples: `/plan-ux`, `/plan-how`, `/fix-build`, `/capture-screenshot`

**Mapping rule: Agent `{scope}` = Command `{object}`**

| Command | Object | Agent | Scope |
|---------|--------|-------|-------|
| `/plan-ux` | `ux` | `ux-designer` | `ux` |
| `/plan-how` | `how` | `how-planner` | `how` |
| `/create-architecture-decision` | `architecture-decision` (long) | `adr-architect` | `adr` |
| `/fix-build` | `build` | `build-fixer` | `build` |
| `/capture-screenshot` | `screenshot` | `screenshot-capturer` | `screenshot` |
| `/code-review` | `code-review` | `code-reviewer` | `code` |

**Exact match exception**: When the command name is short and unambiguous, the agent can match exactly (e.g., `/commit` -> `commit` agent, `/push-to-remote` -> `push-to-remote` agent).

## Agent Conventions

**Frontmatter (required fields):**
- `name` -- kebab-case identifier
- `description` -- clear purpose and when to use
- `tools` -- list of required tools
- `skills` -- list all skills the agent needs (no auto-inheritance). Optional if the agent needs no skills.

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
- Delegate to a subagent for actual work, UNLESS:
  - Interactive: requires back-and-forth dialogue with the user during execution (e.g., `/investigate`)
  - Trivial: a few simple operations where subagent overhead exceeds the work itself (e.g., `/verify`)
- Include a "Next Commands" section when the command has natural follow-up steps in a workflow.
- Include a "Prerequisites" section if the command requires prior state.

## Rule Conventions

- Always loaded in main session only (not in agents).
- Lightweight principles, language-agnostic.
- Content needed in both main session and agents --> put in a Skill instead of a Rule.

## Agent Responsibility Boundaries

Reviewers have non-overlapping responsibilities:

| Agent | Scope |
|-------|-------|
| `code-reviewer` | Code quality: integrity, readability, comments, best practices |
| `security-reviewer` | All security and OWASP concerns |
| `performance-reviewer` | Algorithmic complexity, memory, rendering, bundle size, caching, network optimization |
| `sre-reviewer` | Observability, resilience, health checks, resource limits, blast radius |
| `database-reviewer` | SQL queries, ORM usage, schema design |
| `dead-code-reviewer` | Unused code, imports, dependencies |
| `claude-config-reviewer` | Claude Code configuration quality and consistency |

## Subagent Constraints

- Subagents return text results only -- no structured data (task IDs, etc.)
- Subagents must NOT use TaskCreate -- task creation is the main session's responsibility. Subagents that use TaskCreate pollute the task list with intermediate work items
- If a command needs tasks created from subagent results, specify this in the command body (e.g., "After the subagent returns, create TaskCreate entries for each action item")
- Subagents cannot spawn other subagents (no nested Task tool usage)

## No Personal or Company Information in Git

This repository is a public dotfiles repo. Git-tracked files must NEVER contain:
- Real names (use `[user]` placeholder or store in `memory/` which is git-ignored)
- Company names, workspace URLs, or internal channel names
- Email addresses, Slack user IDs, or employee identifiers
- API tokens, OAuth secrets, or credentials

Personal/company-specific values go in `memory/` (e.g., `memory/slack-profile.md`) or `settings.local.json`.

## Anti-Patterns

- Putting workflow steps in a skill (belongs in agent)
- Putting shared principles in an agent (belongs in skill)
- Putting agent-needed content in a rule (rules are main-session only)
- Duplicating content between a skill and the agents that load it
- Downgrading model (sonnet, haiku) in plans or agent definitions without user instruction
- Omitting skills from agent frontmatter when the agent's responsibilities require shared principles
- Commands doing substantial work directly instead of delegating to a subagent
- Giving subagents TaskCreate/TaskUpdate tools -- causes intermediate task pollution
- Hardcoding personal names, company names, or usernames in git-tracked config files
