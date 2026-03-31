#!/bin/bash

# Configure MCP servers for Claude CLI.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/.env}"

if [ -f "$ENV_FILE" ]; then
    set -a
    # shellcheck source=/dev/null
    . "$ENV_FILE"
    set +a
fi

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
require_env GITHUB_TOKEN

"$SCRIPT_DIR/write-mcp-json.sh"

run_mcp() {
    local output
    if output=$("$@" 2>&1); then
        echo "$output"
        return 0
    fi

    if echo "$output" | grep -Eq "already exists|exists in \.mcp\.json"; then
        echo "$output"
        echo "Skipping (already exists)."
        return 0
    fi

    echo "$output" >&2
    return 1
}

run_mcp claude mcp add --transport http gtm-agent \
  https://gtm-agent-b8803b32b08057d4968c5f671d7e0149.us.langgraph.app/mcp \
  --header "x-api-key: ${GTM_AGENT_API_KEY}" \
  --header "X-Tenant-Id: ${GTM_AGENT_TENANT_ID}" \
  --scope project

run_mcp claude mcp add --transport http linear-server \
  https://mcp.linear.app/mcp \
  --scope local

run_mcp claude mcp add --transport http notion \
  https://mcp.notion.com/mcp \
  --scope local

run_mcp claude mcp add --transport http hex \
  https://app.hex.tech/mcp \
  --scope local

run_mcp claude mcp add slack \
  npx -- -y @modelcontextprotocol/server-slack \
  -e SLACK_BOT_TOKEN="${SLACK_BOT_TOKEN}" \
  -e SLACK_TEAM_ID="${SLACK_TEAM_ID}" \
  --scope local

run_mcp claude mcp add-json github \
  "{\"type\":\"http\",\"url\":\"https://api.githubcopilot.com/mcp\",\"headers\":{\"Authorization\":\"Bearer ${GITHUB_TOKEN}\"}}"

echo "Claude MCP setup complete."
