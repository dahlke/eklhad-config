#!/bin/bash

# Export Cursor settings and keybindings to repo files.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
OUTPUT_DIR="${CURSOR_BACKUP_DIR:-$REPO_ROOT/data/cursor}"
CURSOR_USER_DIR="${CURSOR_USER_DIR:-$HOME/Library/Application Support/Cursor/User}"

mkdir -p "$OUTPUT_DIR"

export_file() {
    local name="$1"
    local src="$CURSOR_USER_DIR/$name"
    local dest="$OUTPUT_DIR/$name"

    if [ -f "$src" ]; then
        cp "$src" "$dest"
        echo "Exported $name to $dest"
    else
        echo "Cursor $name not found at $src; skipping."
    fi
}

export_file "settings.json"
export_file "keybindings.json"
