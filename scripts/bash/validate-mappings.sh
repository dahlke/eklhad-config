#!/bin/bash

# Validate that repo_path entries in file-mappings.json exist.
# Usage: ./validate-mappings.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MAPPINGS_FILE="$REPO_ROOT/file-mappings.json"

if [ ! -f "$MAPPINGS_FILE" ]; then
    echo "Error: file-mappings.json not found at $MAPPINGS_FILE"
    exit 1
fi

missing_count=0

while read -r mapping; do
    name=$(echo "$mapping" | jq -r '.name')
    repo_path=$(echo "$mapping" | jq -r '.repo_path')

    if [ -z "$repo_path" ] || [ "$repo_path" = "null" ]; then
        echo "Missing repo_path for mapping: $name"
        missing_count=$((missing_count + 1))
        continue
    fi

    repo_path_full="$REPO_ROOT/$repo_path"
    if [ ! -f "$repo_path_full" ]; then
        echo "Missing repo file for mapping: $name ($repo_path)"
        missing_count=$((missing_count + 1))
    fi
done < <(jq -c '.mappings[]' "$MAPPINGS_FILE")

if [ "$missing_count" -gt 0 ]; then
    echo ""
    echo "Validation failed: $missing_count missing file(s)."
    exit 1
fi

echo "Validation passed: all repo_path entries exist."
