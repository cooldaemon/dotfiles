---
description: "Check Slack DMs, channel mentions, and participating threads, identify items needing replies, and create a task list"
---

I'll use the slack-assistant subagent to check Slack mentions.

**Task type: CHECK**

The slack-assistant subagent will:
- Read `docs/slack/check-log.md` for the last check timestamp
- Search DMs, channel mentions, and participating threads incrementally (only new messages since last check)
- On first run (no state file), search from yesterday onward
- Categorize with ball-ownership triage (Case 1: reminder, Case 2: response needed, Case 3: mark as read)
- Write updated state to `docs/slack/check-log.md`
- Return a structured text summary to the main session

After the subagent returns, create TaskCreate entries for each "requires action" item, then present the full list and discuss which items to address.

## check-log.md Sync Rule (CRITICAL)

**Any time a task is resolved — whether via TaskUpdate(completed), a reply is sent, or the user dismisses an item — immediately update the corresponding row's Status to `done` in `docs/slack/check-log.md` in the same action.** Do not defer this update. Failing to sync leaves items as `open`, causing them to reappear on the next `/check-slack` run.

Triggers that require a sync:
- TaskUpdate status → `completed`
- A reply is sent via `/reply-to-slack` or directly via Slack MCP
- User explicitly says the item is already handled or no longer needed

## MCP Failure

If the subagent reports that Slack MCP tools are unavailable or returns no results due to MCP errors, do NOT attempt to work around it. Instead, tell the user to run `/mcp` to reconnect the Slack MCP server, then retry `/check-slack`.

## Next Commands

After checking Slack:
- `/reply-to-slack` - Reply to a specific message from the task list
- `/post-to-slack` - Compose and send a new message
