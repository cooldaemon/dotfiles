---
description: "Reply to a specific Slack message or thread after discussing the reply content"
---

I'll use the slack-assistant subagent to send a reply on Slack.

**Task type: REPLY**

The slack-assistant subagent will:
- Look up channel ID and message TS from `docs/slack/check-log.md` (avoids re-searching Slack)
- Read the target message or thread for context
- Draft a reply following bilingual and AI disclosure policies
- Present the draft for user confirmation
- Send the reply only after explicit approval

Provide the channel and message context (e.g., from `/check-slack` task list) as arguments.

## Prerequisites

- Run `/check-slack` first to identify messages needing replies (populates `docs/slack/check-log.md`), or provide channel/thread context directly

## MCP Failure

If the subagent reports that Slack MCP tools are unavailable or returns no results due to MCP errors, do NOT attempt to work around it. Instead, tell the user to run `/mcp` to reconnect the Slack MCP server, then retry `/reply-to-slack`.

## Next Commands

After replying:
- `/check-slack` - Check for more unreads
- `/reply-to-slack` - Reply to another message
- `/post-to-slack` - Compose a new message
