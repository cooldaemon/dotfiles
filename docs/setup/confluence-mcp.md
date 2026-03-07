# Confluence MCP Setup

> Referenced from CLAUDE.md. This guide is needed once per machine when `make mcp-update` skips Confluence due to missing credentials.

When `make mcp-update` skips Confluence (credentials not set), guide the user through these steps:

## 1. Create API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token" (classic, not scoped -- scoped tokens do not work with Confluence REST API)
3. Set a label (e.g., "For Claude Code")
4. Copy the generated token

## 2. Register MCP Server

```bash
export CONFLUENCE_URL="https://your-company.atlassian.net/wiki"
export CONFLUENCE_USERNAME="your.email@company.com"
export CONFLUENCE_API_TOKEN="your_api_token"
make mcp-update
```

Credentials are stored in Claude Code's MCP config after registration. The environment variables are only needed during `make mcp-update`.

## Notes

- **Write operations**: Page create/update/delete and comment add/reply are enabled but require user confirmation each time (not auto-allowed)
- **Confluence Cloud only**: Server/Data Center deployments are not supported by this configuration
- **Toolsets**: Only `confluence_pages` and `confluence_comments` toolsets are enabled (no Jira tools)
