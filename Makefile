SHELL := /bin/bash

.PHONY: validate audit links bootstrap macos-setup macos-open-apps mcp-claude mcp-codex mcp-deepagents export-brewfile
.PHONY: cursor-export cursor-install cursor-export-settings cursor-install-settings check-sensitive

validate:
	./scripts/bash/validate-mappings.sh

audit:
	./scripts/bash/audit-configs.sh

links:
	./scripts/bash/check-md-links.sh

bootstrap:
	./scripts/bash/bootstrap.sh

macos-setup:
	./scripts/bash/macos/setup.sh

macos-open-apps:
	./scripts/bash/macos/open-apps.sh

mcp-claude:
	./scripts/bash/mcp/setup-claude.sh

mcp-codex:
	./scripts/bash/mcp/setup-codex.sh

mcp-deepagents:
	./scripts/bash/mcp/setup-deepagents.sh

export-brewfile:
	./scripts/bash/export-brewfile.sh

cursor-export:
	./scripts/bash/cursor/export-extensions.sh

cursor-install:
	./scripts/bash/cursor/install-extensions.sh

cursor-export-settings:
	./scripts/bash/cursor/export-settings.sh

cursor-install-settings:
	./scripts/bash/cursor/install-settings.sh

check-sensitive:
	./scripts/bash/check-sensitive.sh
