---
description: "Check Slack DMs and channel mentions, identify items needing replies, and create a task list"
---

I'll use the slack-assistant subagent to check Slack mentions.

**Task type: CHECK**

The slack-assistant subagent will:
- Search DMs (`to:me`) and channel mentions for the user for today
- Categorize as "requires action" or "awareness only"
- Return a structured task list for the main session

After the subagent returns, I will present the task list and discuss which items to address.

## Next Commands

After checking Slack:
- `/reply-to-slack` - Reply to a specific message from the task list
- `/post-to-slack` - Compose and send a new message
