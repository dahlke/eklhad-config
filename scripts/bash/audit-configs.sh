#!/bin/bash

# Audit file-mappings.json for consistency.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MAPPINGS_FILE="$REPO_ROOT/file-mappings.json"

if [ ! -f "$MAPPINGS_FILE" ]; then
    echo "Missing file-mappings.json at $MAPPINGS_FILE"
    exit 1
fi

duplicates=$(jq -r '.mappings[].name' "$MAPPINGS_FILE" | sort | uniq -d || true)
if [ -n "$duplicates" ]; then
    echo "Duplicate mapping names found:"
    echo "$duplicates"
    exit 1
fi

missing=0

while read -r mapping; do
    name=$(echo "$mapping" | jq -r '.name')
    repo_path=$(echo "$mapping" | jq -r '.repo_path')
    system_path=$(echo "$mapping" | jq -r '.system_path')
    applicable=$(echo "$mapping" | jq -r '.applicable')

    if [ -z "$name" ] || [ "$name" = "null" ]; then
        echo "Missing name field in mapping."
        missing=1
    fi

    if [ -z "$repo_path" ] || [ "$repo_path" = "null" ]; then
        echo "Missing repo_path for mapping: $name"
        missing=1
    else
        repo_path_full="$REPO_ROOT/$repo_path"
        if [ ! -f "$repo_path_full" ]; then
            echo "Missing repo file for mapping: $name ($repo_path)"
            missing=1
        fi
    fi

    if [ "$applicable" = "true" ]; then
        if [ -z "$system_path" ] || [ "$system_path" = "null" ]; then
            echo "Applicable mapping without system_path: $name"
            missing=1
        fi
    fi
done < <(jq -c '.mappings[]' "$MAPPINGS_FILE")

if [ "$missing" -ne 0 ]; then
    echo ""
    echo "Config audit failed."
    exit 1
fi

echo "Config audit OK."
