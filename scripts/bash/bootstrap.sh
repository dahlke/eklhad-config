#!/bin/bash

# Repo bootstrap and checks.
# Usage: ./scripts/bash/bootstrap.sh [--macos]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

"$REPO_ROOT/scripts/bash/validate-mappings.sh"
"$REPO_ROOT/scripts/bash/audit-configs.sh"
"$REPO_ROOT/scripts/bash/check-md-links.sh"

if [ "${1:-}" = "--macos" ]; then
    "$REPO_ROOT/scripts/bash/macos/setup.sh"
fi

echo "Bootstrap complete."
