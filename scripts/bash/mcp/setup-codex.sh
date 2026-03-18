#!/bin/bash

# Configure MCP servers for Codex via project-scoped config.toml.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CONFIG_PATH="${CODEX_CONFIG_PATH:-$REPO_ROOT/.codex/config.toml}"

if ! command -v codex >/dev/null 2>&1; then
    echo "Missing required command: codex"
    exit 1
fi

mkdir -p "$(dirname "$CONFIG_PATH")"

if [ -f "$CONFIG_PATH" ]; then
    backup_path="${CONFIG_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_PATH" "$backup_path"
    echo "Backed up existing config to $backup_path"
fi

cat > "$CONFIG_PATH" <<'EOF'
[mcp_servers.gtm-agent]
url = "https://gtm-agent-b8803b32b08057d4968c5f671d7e0149.us.langgraph.app/mcp"
env_http_headers = { "x-api-key" = "GTM_AGENT_API_KEY", "X-Tenant-Id" = "GTM_AGENT_TENANT_ID" }

[mcp_servers.linear-server]
url = "https://mcp.linear.app/mcp"

[mcp_servers.notion]
url = "https://mcp.notion.com/mcp"

[mcp_servers.hex]
url = "https://app.hex.tech/mcp"

[mcp_servers.slack]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-slack"]
env_vars = ["SLACK_BOT_TOKEN", "SLACK_TEAM_ID"]

[mcp_servers.github]
url = "https://api.githubcopilot.com/mcp"
bearer_token_env_var = "GITHUB_TOKEN"
EOF

echo "Wrote Codex MCP config to $CONFIG_PATH"
echo "Tip: set GTM_AGENT_API_KEY, GTM_AGENT_TENANT_ID, SLACK_BOT_TOKEN, SLACK_TEAM_ID, GITHUB_TOKEN in your shell."
