#!/bin/bash

# Script to apply configuration files from the repo to the system
# Usage: ./apply-configs.sh

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

echo "Applying configuration files from repo to system..."
echo ""

# Read the JSON file and process each mapping
jq -c '.mappings[]' "$MAPPINGS_FILE" | while read -r mapping; do
    name=$(echo "$mapping" | jq -r '.name')
    repo_path=$(echo "$mapping" | jq -r '.repo_path')
    system_path=$(echo "$mapping" | jq -r '.system_path')
    applicable=$(echo "$mapping" | jq -r '.applicable')
    note=$(echo "$mapping" | jq -r '.note // empty')
    
    # Expand ~ in system_path
    system_path_expanded="${system_path/#\~/$HOME}"
    repo_path_full="$REPO_ROOT/$repo_path"
    
    echo "Processing: $name"
    
    if [ "$applicable" != "true" ]; then
        echo "  ⚠️  Cannot apply: $name"
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
    
    if [ ! -f "$repo_path_full" ]; then
        echo "  ⚠️  Source file not found in repo: $repo_path_full"
        echo ""
        continue
    fi
    
    # Create directory if it doesn't exist
    system_dir=$(dirname "$system_path_expanded")
    mkdir -p "$system_dir"
    
    # Backup existing file if it exists
    if [ -f "$system_path_expanded" ]; then
        backup_path="${system_path_expanded}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$system_path_expanded" "$backup_path"
        echo "  ℹ️  Backed up existing file to: $backup_path"
    fi
    
    # Copy the file
    if cp "$repo_path_full" "$system_path_expanded"; then
        echo "  ✓ Applied: $repo_path -> $system_path_expanded"
    else
        echo "  ✗ Failed to apply: $name"
    fi
    echo ""
done

echo "Application complete!"

