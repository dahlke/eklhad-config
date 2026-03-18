#!/bin/bash

# Export the local Homebrew state into Brewfile.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
BREWFILE="$REPO_ROOT/Brewfile"

if ! command -v brew >/dev/null 2>&1; then
    echo "Missing required command: brew"
    exit 1
fi

brew bundle dump --file "$BREWFILE" --force
echo "Exported Brewfile to $BREWFILE"
