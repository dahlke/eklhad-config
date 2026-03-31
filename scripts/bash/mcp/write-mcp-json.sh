#!/bin/bash

# Generate a project-level .mcp.json for MCP clients (Deep Agents, Claude Code).

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
OUTPUT_PATH="${MCP_JSON_PATH:-$REPO_ROOT/.mcp.json}"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/.env}"

if [ -f "$ENV_FILE" ]; then
    set -a
    # shellcheck source=/dev/null
    . "$ENV_FILE"
    set +a
fi

gtm_api_key="${GTM_AGENT_API_KEY:-}"
gtm_tenant_id="${GTM_AGENT_TENANT_ID:-}"
slack_bot_token="${SLACK_BOT_TOKEN:-}"
slack_team_id="${SLACK_TEAM_ID:-}"
github_token="${GITHUB_TOKEN:-}"

if [ -z "$gtm_api_key" ] || [ -z "$gtm_tenant_id" ]; then
    echo "Warning: GTM_AGENT_API_KEY or GTM_AGENT_TENANT_ID is missing. Using placeholder values."
fi

if [ -z "$slack_bot_token" ] || [ -z "$slack_team_id" ]; then
    echo "Warning: SLACK_BOT_TOKEN or SLACK_TEAM_ID is missing. Using placeholder values."
fi

if [ -z "$github_token" ]; then
    echo "Warning: GITHUB_TOKEN is missing. Using placeholder value."
fi

tmp_file="$(mktemp)"
jq -n \
  --arg gtm_api_key "${gtm_api_key:-XXX}" \
  --arg gtm_tenant_id "${gtm_tenant_id:-XXX}" \
  --arg slack_bot_token "${slack_bot_token:-XXX}" \
  --arg slack_team_id "${slack_team_id:-XXX}" \
  --arg github_token "${github_token:-XXX}" \
  '{
    mcpServers: {
      "gtm-agent": {
        type: "http",
        url: "https://gtm-agent-b8803b32b08057d4968c5f671d7e0149.us.langgraph.app/mcp",
        headers: {
          "x-api-key": $gtm_api_key,
          "X-Tenant-Id": $gtm_tenant_id
        }
      },
      "linear-server": {
        type: "http",
        url: "https://mcp.linear.app/mcp"
      },
      "notion": {
        type: "http",
        url: "https://mcp.notion.com/mcp"
      },
      "hex": {
        type: "http",
        url: "https://app.hex.tech/mcp"
      },
      "slack": {
        command: "npx",
        args: ["-y", "@modelcontextprotocol/server-slack"],
        env: {
          SLACK_BOT_TOKEN: $slack_bot_token,
          SLACK_TEAM_ID: $slack_team_id
        }
      },
      "github": {
        type: "http",
        url: "https://api.githubcopilot.com/mcp",
        headers: {
          Authorization: ("Bearer " + $github_token)
        }
      }
    }
  }' > "$tmp_file"

if [ -f "$OUTPUT_PATH" ]; then
    backup_path="${OUTPUT_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$OUTPUT_PATH" "$backup_path"
    echo "Backed up existing .mcp.json to $backup_path"
fi

mv "$tmp_file" "$OUTPUT_PATH"
echo "Wrote MCP config to $OUTPUT_PATH"
