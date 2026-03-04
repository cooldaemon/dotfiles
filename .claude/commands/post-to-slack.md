---
description: "Compose and send a new Slack message to a channel or DM"
---

I'll use the slack-assistant subagent to compose and send a new message on Slack.

**Task type: POST**

The slack-assistant subagent will:
- Identify the target channel or DM
- Compose a message following bilingual and AI disclosure policies
- Present the draft for user confirmation
- Send the message only after explicit approval

Provide the target channel and message idea as arguments.

## MCP Failure

If the subagent reports that Slack MCP tools are unavailable or returns no results due to MCP errors, do NOT attempt to work around it. Instead, tell the user to run `/mcp` to reconnect the Slack MCP server, then retry `/post-to-slack`.

## Next Commands

After posting:
- `/check-slack` - Check for new unreads or reactions
- `/reply-to-slack` - Reply to a follow-up message
- `/post-to-slack` - Send another message
