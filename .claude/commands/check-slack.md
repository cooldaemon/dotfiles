---
description: "Check Slack DMs and channel mentions, identify items needing replies, and create a task list"
---

I'll use the slack-assistant subagent to check Slack mentions.

**Task type: CHECK**

The slack-assistant subagent will:
- Read `docs/slack/check-log.md` for the last check timestamp
- Search DMs and channel mentions incrementally (only new messages since last check)
- On first run (no state file), search from yesterday onward
- Categorize with ball-ownership triage (Case 1: reminder, Case 2: response needed, Case 3: mark as read)
- Write updated state to `docs/slack/check-log.md`
- Return a structured text summary to the main session

After the subagent returns, create TaskCreate entries for each "requires action" item, then present the full list and discuss which items to address. When the user marks an item as handled or dismisses it, update its Status to `done` in `docs/slack/check-log.md` so it won't reappear in future runs.

## MCP Failure

If the subagent reports that Slack MCP tools are unavailable or returns no results due to MCP errors, do NOT attempt to work around it. Instead, tell the user to run `/mcp` to reconnect the Slack MCP server, then retry `/check-slack`.

## Next Commands

After checking Slack:
- `/reply-to-slack` - Reply to a specific message from the task list
- `/post-to-slack` - Compose and send a new message
