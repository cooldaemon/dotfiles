---
description: "Manage Architecture Decision Records (ADRs) - create directory structure, analyze git log and session for technical decisions, and create new ADR files"
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, LS, TodoWrite
---

# ADR Management

Manage Architecture Decision Records (ADRs) for your project. This command helps you:
- Create the initial `docs/adr` directory structure with template.md and index.md
- Analyze recent git commits and session content for technical decisions
- Generate new ADR files with proper numbering
- Update the index.md file automatically

## Process

1. **Check ADR Directory**: 
   - If `docs/adr` doesn't exist, create it with template.md and index.md
   - If it exists, check existing ADR files

2. **Analyze Technical Decisions**:
   - Review git log for recent commits that might contain technical decisions
   - Look for keywords: implement, add, introduce, migrate, switch, replace, use, adopt, choose, decide
   - Check session history and CLAUDE.md for architectural insights

3. **Create New ADR**:
   - Determine the next ADR number (format: NNNN)
   - Create a new file using the template
   - Update index.md with the new entry

## ADR Template Format

When creating template.md, use this exact format:

```markdown
# [Title of the Architectural Decision]

## Context and Problem Statement

[Describe the context and problem statement, e.g., in free form using two to three sentences or as a bulleted list.]

## Considered Options

* [Option 1]
* [Option 2]
* [Option 3]

## Decision Outcome

Chosen option: "[Option X]", because [justification. e.g., only option, which meets k.o. criterion decision driver | which resolves force force | ... | comes out best (see below)].

## Consequences

* Positive:
  * [e.g., improvement of quality attribute satisfaction, follow-up decisions required, ...]
  * [...]
* Negative:
  * [e.g., compromising quality attribute, follow-up decisions required, ...]
  * [...]
```

## Index.md Structure

When creating index.md, use this format:

```markdown
# Architectural Decision Records

This directory contains Architectural Decision Records (ADRs) for the project.

## What is an ADR?

An Architectural Decision Record (ADR) is a document that captures an important architectural decision made along with its context and consequences.

## ADR Files

## Creating New ADRs

To create a new ADR:

1. Copy the template from [template.md](template.md)
2. Name the new file following the convention: `NNNN-title-with-hyphens.md` where `NNNN` is the next available number
3. Fill in the template with your decision
4. Add a link to the new ADR in this index file
```

## Examples of Technical Decisions to Document

- Architecture patterns (e.g., "Use microservices architecture")
- Technology choices (e.g., "Use React for frontend")
- Integration decisions (e.g., "Use AWS Lambda for serverless functions")
- Development practices (e.g., "Adopt trunk-based development")
- Security decisions (e.g., "Implement OAuth2 for authentication")
- Performance optimizations (e.g., "Use Redis for caching")

## Usage Notes

- ADR files should be numbered sequentially (0001, 0002, etc.)
- File names should use hyphens to separate words
- Keep ADR titles concise but descriptive
- Focus on the "why" of decisions, not just the "what"
- Include both positive and negative consequences
- When updating index.md, new ADR entries should be added in the "## ADR Files" section using the format: `* [ADR-NNNN](NNNN-title.md) - Title`