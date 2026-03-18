#!/bin/bash

# Install Cursor extensions from repo file.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
INPUT="${CURSOR_EXTENSIONS_PATH:-$REPO_ROOT/data/cursor/extensions.txt}"

if ! command -v cursor >/dev/null 2>&1; then
    echo "Cursor CLI not found."
    exit 1
fi

if [ ! -f "$INPUT" ]; then
    echo "Missing extensions list at $INPUT"
    exit 1
fi

while IFS= read -r ext; do
    if [ -n "$ext" ]; then
        cursor --install-extension "$ext"
    fi
done < "$INPUT"

echo "Installed Cursor extensions from $INPUT"
