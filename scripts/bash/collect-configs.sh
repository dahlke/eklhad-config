#!/bin/bash

# Script to collect configuration files from the system to the repo
# Usage: ./collect-configs.sh

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the repo root (parent of scripts directory)
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MAPPINGS_FILE="$REPO_ROOT/file-mappings.json"

if [ ! -f "$MAPPINGS_FILE" ]; then
    echo "Error: file-mappings.json not found at $MAPPINGS_FILE"
    exit 1
fi

echo "Collecting configuration files from system to repo..."
echo ""

# Read the JSON file and process each mapping
jq -c '.mappings[]' "$MAPPINGS_FILE" | while read -r mapping; do
    name=$(echo "$mapping" | jq -r '.name')
    repo_path=$(echo "$mapping" | jq -r '.repo_path')
    system_path=$(echo "$mapping" | jq -r '.system_path')
    collectable=$(echo "$mapping" | jq -r '.collectable')
    note=$(echo "$mapping" | jq -r '.note // empty')

    # Expand ~ in system_path
    system_path_expanded="${system_path/#\~/$HOME}"
    repo_path_full="$REPO_ROOT/$repo_path"

    echo "Processing: $name"

    if [ "$collectable" != "true" ]; then
        echo "  ⚠️  Cannot collect: $name"
        if [ -n "$note" ]; then
            echo "     Note: $note"
        fi
        echo ""
        continue
    fi

    if [ -z "$system_path" ] || [ "$system_path" = "null" ]; then
        echo "  ⚠️  No system path defined for: $name"
        echo ""
        continue
    fi

    if [ ! -f "$system_path_expanded" ]; then
        echo "  ⚠️  Source file not found: $system_path_expanded"
        echo ""
        continue
    fi

    # Create directory if it doesn't exist
    repo_dir=$(dirname "$repo_path_full")
    mkdir -p "$repo_dir"

    # Copy the file
    if cp "$system_path_expanded" "$repo_path_full"; then
        echo "  ✓ Collected: $system_path -> $repo_path"
    else
        echo "  ✗ Failed to collect: $name"
    fi
    echo ""
done

echo "Collection complete!"

