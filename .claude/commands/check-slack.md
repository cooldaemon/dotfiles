---
description: "Check Slack DMs and channel mentions, identify items needing replies, and create a task list"
---

I'll use the slack-assistant subagent to check Slack mentions.

**Task type: CHECK**

The slack-assistant subagent will:
- Search DMs (`to:me`) and channel mentions for the user for today
- Categorize with ball-ownership triage (Case 1: reminder, Case 2: response needed, Case 3: mark as read)
- Return a structured text summary to the main session

After the subagent returns, create TaskCreate entries for each "requires action" item, then present the full list and discuss which items to address.

## Next Commands

After checking Slack:
- `/reply-to-slack` - Reply to a specific message from the task list
- `/post-to-slack` - Compose and send a new message
