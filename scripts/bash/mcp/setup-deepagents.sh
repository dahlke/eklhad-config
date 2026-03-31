#!/bin/bash

# Generate .mcp.json and run Deep Agents CLI.

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

if ! command -v deepagents >/dev/null 2>&1; then
    echo "Missing required command: deepagents"
    exit 1
fi

"$SCRIPT_DIR/write-mcp-json.sh"

echo "Starting deepagents (use --trust-project-mcp if needed)..."
deepagents
