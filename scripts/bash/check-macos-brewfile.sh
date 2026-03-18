#!/bin/bash

# Ensure brew installs mentioned in MACOS.md exist in Brewfile.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
BREWFILE="$REPO_ROOT/Brewfile"
MACOS_MD="$REPO_ROOT/MACOS.md"

if [ ! -f "$BREWFILE" ]; then
    echo "Missing Brewfile at $BREWFILE"
    exit 1
fi

if [ ! -f "$MACOS_MD" ]; then
    echo "Missing MACOS.md at $MACOS_MD"
    exit 1
fi

brew_pkgs="$(awk -F'"' '/^brew "/{print $2}' "$BREWFILE")"
cask_pkgs="$(awk -F'"' '/^cask "/{print $2}' "$BREWFILE")"

missing=0

while IFS= read -r line; do
    case "$line" in
        *"brew install --cask "*)
            pkgs="${line#*brew install --cask }"
            for pkg in $pkgs; do
                if ! printf '%s\n' "$cask_pkgs" | grep -qx "$pkg"; then
                    echo "Missing cask in Brewfile: $pkg"
                    missing=1
                fi
            done
            ;;
        *"brew install "*)
            pkgs="${line#*brew install }"
            for pkg in $pkgs; do
                if ! printf '%s\n' "$brew_pkgs" | grep -qx "$pkg"; then
                    echo "Missing brew package in Brewfile: $pkg"
                    missing=1
                fi
            done
            ;;
        *)
            ;;
    esac
done < "$MACOS_MD"

if [ "$missing" -ne 0 ]; then
    echo ""
    echo "Brewfile is missing packages referenced in MACOS.md."
    exit 1
fi

echo "Brewfile matches MACOS.md brew installs."
