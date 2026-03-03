#!/bin/bash
# Check that Slack messages include AI disclosure footer
INPUT=$(cat)
TEXT=$(echo "$INPUT" | jq -r '.tool_input.text // empty')

if [ -z "$TEXT" ]; then
  exit 0
fi

# Check for English or Japanese disclosure footer
if echo "$TEXT" | grep -q "composed and posted by Claude" || echo "$TEXT" | grep -q "Claudeが.*代理で作成・投稿"; then
  exit 0
fi

# Block: disclosure footer missing
jq -n '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: "AI disclosure footer missing. Append one of:\n- English: _This message was composed and posted by Claude on behalf of [user]._\n- Japanese: _このメッセージはClaudeが[user]の代理で作成・投稿しました。_"
  }
}'
