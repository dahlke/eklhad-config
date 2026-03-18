# eklhad-config

How I like to configure my software.

- [Mac OS](./MACOS.md)
- [Raspberry Pi](./PI.MD)

## Quickstart

Prereqs:

- `jq`
- `1password-cli` (optional, for `static/secrets.op.sh`)

Common tasks:

- Validate mappings: `./scripts/bash/validate-mappings.sh`
- Apply configs to system: `./scripts/bash/apply-configs.sh`
- Collect configs from system: `./scripts/bash/collect-configs.sh`
- Check docs links: `./scripts/bash/check-md-links.sh`
- Bootstrap checks: `./scripts/bash/bootstrap.sh`

Makefile shortcuts:

- `make validate`
- `make audit`
- `make links`
- `make macos-setup`
- `make cursor-export`
- `make cursor-install`
- `make cursor-export-settings`
- `make cursor-install-settings`
- `make check-sensitive`

## File mappings

`file-mappings.json` is the source of truth for config files. Each entry maps a
`repo_path` to a `system_path` and marks whether it is collectable/applicable.

## Raspberry Pi

Terraform automation lives under `terraform/rasppi`. See
`terraform/rasppi/README.md` for usage details.
