# Slack MCP Setup

> Referenced from CLAUDE.md. This guide is needed once per machine when `make mcp-update` skips Slack due to missing credentials.

When `make mcp-update` skips Slack (token not set), guide the user through these steps:

## 1. Create Slack App

1. Go to https://api.slack.com/apps -> "Create New App" -> "From scratch"
2. Go to **App Manifest** (JSON tab) and set `oauth_config.scopes.user` to:

```json
          "user": [
              "channels:history",
              "channels:read",
              "channels:write",
              "chat:write",
              "groups:history",
              "groups:read",
              "groups:write",
              "im:history",
              "im:read",
              "im:write",
              "mpim:history",
              "mpim:read",
              "mpim:write",
              "reactions:read",
              "reactions:write",
              "search:read",
              "users:read",
              "usergroups:read"
          ]
```

3. Save Changes -> Install to Workspace (admin approval may be required)
4. Copy **User OAuth Token** (`xoxp-...`) from OAuth & Permissions page

## 2. Register MCP Server

```bash
export SLACK_MCP_XOXP_TOKEN="xoxp-..."
make mcp-update
```

Token is stored in Claude Code's MCP config after registration. The environment variable is only needed during `make mcp-update`.
