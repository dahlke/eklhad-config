#!/bin/bash

# Validate relative links in markdown files.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

REPO_ROOT="$REPO_ROOT" python - <<'PY'
from __future__ import annotations

import re
import sys
import os
from pathlib import Path

repo = Path(os.environ["REPO_ROOT"])
md_files = list(repo.rglob("*.md"))

link_re = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
missing = []

def is_external(target: str) -> bool:
    return target.startswith(("http://", "https://", "mailto:", "tel:"))

for md_file in md_files:
    try:
        text = md_file.read_text(encoding="utf-8")
    except Exception:
        continue
    for match in link_re.finditer(text):
        raw = match.group(1).strip()
        if raw.startswith("<") and raw.endswith(">"):
            raw = raw[1:-1]
        target = raw.split()[0].split("#")[0].strip()
        if not target or target == "#":
            continue
        if is_external(target):
            continue
        if target.startswith("#"):
            continue

        if target.startswith("/"):
            candidate = (repo / target.lstrip("/")).resolve()
        else:
            candidate = (md_file.parent / target).resolve()

        if not candidate.exists():
            missing.append((md_file.relative_to(repo), target))

if missing:
    print("Broken relative links:")
    for md, target in missing:
        print(f"- {md}: {target}")
    sys.exit(1)

print("Markdown links OK.")
PY
