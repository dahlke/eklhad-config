#!/bin/bash

# Simple secret scan for common token patterns.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

patterns=(
    "AKIA[0-9A-Z]{16}"                          # AWS access key
    "ghp_[A-Za-z0-9]{36,}"                       # GitHub token
    "gho_[A-Za-z0-9]{36,}"                       # GitHub token (oauth)
    "xoxb-[A-Za-z0-9-]{20,}"                     # Slack bot token
    "sk-[A-Za-z0-9]{20,}"                        # Generic secret key
    "Bearer[[:space:]]+[A-Za-z0-9._-]{20,}"      # Bearer token
)

ignore_globs=(
    ".git/**"
    ".terraform/**"
    "node_modules/**"
    "data/cursor/**"
    ".codex/**"
    ".deepagents/**"
    ".mcp.json"
)

rg_args=()
for glob in "${ignore_globs[@]}"; do
    rg_args+=(--glob "!${glob}")
done

found=0
for pattern in "${patterns[@]}"; do
    if rg "${rg_args[@]}" -n "$pattern" .; then
        found=1
    fi
done

if [ "$found" -ne 0 ]; then
    echo ""
    echo "Potential secrets detected. Review before committing."
    exit 1
fi

echo "No obvious secrets detected."
