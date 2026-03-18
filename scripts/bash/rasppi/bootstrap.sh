#!/bin/bash

# Bootstrap a Raspberry Pi node.
# Run this on the Pi.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/install.sh"

echo "Raspberry Pi bootstrap complete."
