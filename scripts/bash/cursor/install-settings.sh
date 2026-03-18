#!/bin/bash

# Install Cursor settings and keybindings from repo files.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
INPUT_DIR="${CURSOR_BACKUP_DIR:-$REPO_ROOT/data/cursor}"
CURSOR_USER_DIR="${CURSOR_USER_DIR:-$HOME/Library/Application Support/Cursor/User}"

mkdir -p "$CURSOR_USER_DIR"

install_file() {
    local name="$1"
    local src="$INPUT_DIR/$name"
    local dest="$CURSOR_USER_DIR/$name"

    if [ -f "$src" ]; then
        cp "$src" "$dest"
        echo "Installed $name to $dest"
    else
        echo "Missing $src; skipping."
    fi
}

install_file "settings.json"
install_file "keybindings.json"
