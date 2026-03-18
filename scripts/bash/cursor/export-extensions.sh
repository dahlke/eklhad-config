#!/bin/bash

# Export Cursor extensions to a repo file.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
OUTPUT="${CURSOR_EXTENSIONS_PATH:-$REPO_ROOT/data/cursor/extensions.txt}"

if ! command -v cursor >/dev/null 2>&1; then
    echo "Cursor CLI not found. Skipping export."
    exit 0
fi

mkdir -p "$(dirname "$OUTPUT")"
cursor --list-extensions | sort > "$OUTPUT"
echo "Exported Cursor extensions to $OUTPUT"
