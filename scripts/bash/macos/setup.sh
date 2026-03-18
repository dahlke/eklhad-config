#!/bin/bash

# Automated macOS setup (brew + configs).
# Usage: ./scripts/bash/macos/setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
BREWFILE="$REPO_ROOT/Brewfile"

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Missing required command: $1"
        exit 1
    fi
}

if ! xcode-select -p >/dev/null 2>&1; then
    echo "Installing Xcode command line tools..."
    xcode-select --install
    echo "Re-run this script after the install completes."
    exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "Homebrew installed. Re-run this script to continue."
    exit 0
fi

require_cmd brew

echo "Updating Homebrew..."
brew update

if [ -f "$BREWFILE" ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file "$BREWFILE"
else
    echo "Missing Brewfile at $BREWFILE"
    exit 1
fi

if [ "${APPLY_CONFIGS:-1}" = "1" ]; then
    echo "Applying repo configs..."
    "$REPO_ROOT/scripts/bash/apply-configs.sh"
fi

echo "Cleaning up Homebrew..."
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/* || true

echo "macOS setup complete."
