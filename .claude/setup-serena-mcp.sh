#!/bin/bash

# Setup Serena MCP server for the current project
# This script configures Serena MCP at project scope with the current directory

set -e

# Get the current directory as the project path
PROJECT_DIR=$(pwd)

echo "Setting up Serena MCP server for project: $PROJECT_DIR"

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "Error: Claude Code is not installed"
    exit 1
fi

# Check if Serena is already configured for this project
if claude mcp list 2>/dev/null | grep -q "serena:"; then
    echo "Serena MCP server is already configured for this project"
    echo "To reconfigure, run: claude mcp remove serena"
    exit 0
fi

# Add Serena MCP server with project scope
echo "Configuring Serena MCP server..."
claude mcp add serena -s project -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$PROJECT_DIR"

# Verify the configuration
echo "Verifying configuration..."
if claude mcp list 2>/dev/null | grep -q "serena:"; then
    echo "✓ Serena MCP server successfully configured for $PROJECT_DIR"
else
    echo "✗ Failed to configure Serena MCP server"
    exit 1
fi