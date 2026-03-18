#!/bin/bash

# Generate .mcp.json and run Deep Agents CLI.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v deepagents >/dev/null 2>&1; then
    echo "Missing required command: deepagents"
    exit 1
fi

"$SCRIPT_DIR/write-mcp-json.sh"

echo "Starting deepagents (use --trust-project-mcp if needed)..."
deepagents
