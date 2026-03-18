#!/bin/bash

# Configure MCP servers for Claude CLI.

set -e

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Missing required command: $1"
        exit 1
    fi
}

require_env() {
    local name="$1"
    if [ -z "${!name}" ]; then
        echo "Missing required env var: $name"
        exit 1
    fi
}

require_cmd claude

require_env GTM_AGENT_API_KEY
require_env GTM_AGENT_TENANT_ID
require_env SLACK_BOT_TOKEN
require_env SLACK_TEAM_ID

claude mcp add --transport http gtm-agent \
  https://gtm-agent-b8803b32b08057d4968c5f671d7e0149.us.langgraph.app/mcp \
  --header "x-api-key: ${GTM_AGENT_API_KEY}" \
  --header "X-Tenant-Id: ${GTM_AGENT_TENANT_ID}" \
  --scope project

claude mcp add --transport http linear-server \
  https://mcp.linear.app/mcp \
  --scope local

claude mcp add --transport http notion \
  https://mcp.notion.com/mcp \
  --scope local

claude mcp add --transport http hex \
  https://app.hex.tech/mcp \
  --scope local

claude mcp add slack \
  npx -- -y @modelcontextprotocol/server-slack \
  -e SLACK_BOT_TOKEN="${SLACK_BOT_TOKEN}" \
  -e SLACK_TEAM_ID="${SLACK_TEAM_ID}" \
  --scope local

echo "Claude MCP setup complete."
