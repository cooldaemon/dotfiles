---
name: slack-communication
description: "Policies for Slack communication via MCP tools. Use when interacting with Slack channels, threads, DMs, or composing Slack messages. Provides bilingual communication rules, AI disclosure requirements, and message composition guidelines."
---

# Slack Communication Policies

## AI Disclosure

All messages sent via Claude MUST include an AI disclosure footer. Append the following to every message payload:

- English messages: `_This message was composed by Claude on behalf of [user]._`
- Japanese messages: `_このメッセージはClaudeが[user]の代理で作成しました。_`
- Bilingual messages: Include both disclosures

## Bilingual Policy

### Japanese Messages

- Use desu/masu form as default
- Match the honorific level (keigo) of the conversation participants
- Keep technical terms in English (e.g., "deploy", "PR", "CI/CD") when that is the channel norm
- When the thread is new or the language is ambiguous, ask the user which language to use

## Confirmation Requirement

Never send a message without explicit user approval. The workflow is:

1. Draft the message with AI disclosure footer appended
2. Present the complete message to the user
3. Send only after explicit approval

## Anti-Patterns

- Sending messages without AI disclosure footer
- Sending without user confirmation
- Replying in a different language than the conversation thread
- Using `conversations_unreads` -- too slow on large workspaces. Use `conversations_search_messages` with `to:me` and `@<username>` instead
