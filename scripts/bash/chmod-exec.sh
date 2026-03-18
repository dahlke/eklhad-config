#!/bin/bash

# Make all repo bash scripts executable.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

find "$REPO_ROOT/scripts" -type f -name "*.sh" -exec chmod +x {} \;

echo "Marked all scripts under scripts/ as executable."
