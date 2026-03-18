# MCP Servers

These scripts help avoid manual copy/paste:

```bash
./scripts/bash/mcp/setup-claude.sh
./scripts/bash/mcp/setup-codex.sh
./scripts/bash/mcp/setup-deepagents.sh
```

Required env vars for the scripts:

- `GTM_AGENT_API_KEY`
- `GTM_AGENT_TENANT_ID`
- `SLACK_BOT_TOKEN`
- `SLACK_TEAM_ID`

## Claude CLI

Scripted setup:

```bash
./scripts/bash/mcp/setup-claude.sh
```

Manual setup (if needed):

```bash
claude mcp add --transport http gtm-agent \
  https://gtm-agent-b8803b32b08057d4968c5f671d7e0149.us.langgraph.app/mcp \
  --header "x-api-key: XXX" \
  --header "X-Tenant-Id: XXX" \
  --scope project

claude mcp add --transport http linear-server \
  https://mcp.linear.app/mcp \
  --scope local

claude mcp add --transport http notion \
  https://mcp.notion.com/mcp \
  --scope local

claude mcp add --transport http hex \
  https://app.hex.tech/mcp \
  --scope local

claude mcp add slack \
  npx -- -y @modelcontextprotocol/server-slack \
  -e SLACK_BOT_TOKEN=XXX \
  -e SLACK_TEAM_ID=XXX \
  --scope local
```

## Codex (CLI + IDE)

Codex reads MCP config from `~/.codex/config.toml` or project-scoped
`.codex/config.toml`. The script below writes a project-scoped config that
references your environment variables (no secrets stored in the file):

```bash
./scripts/bash/mcp/setup-codex.sh
```

You can also use `codex mcp --help` and `codex mcp add` to manage servers.

## LangChain Deep Agents

Deep Agents auto-discovers `.mcp.json` at the project root. The script below
writes `.mcp.json` and launches the CLI:

```bash
./scripts/bash/mcp/setup-deepagents.sh
```

If you want to only generate the config file:

```bash
./scripts/bash/mcp/write-mcp-json.sh
```

Deep Agents may prompt to trust project-level stdio servers. If you want to
skip prompts in automation, run `deepagents --trust-project-mcp`.

## github (todo)

```bash
claude mcp add-json github \
  '{"type":"http","url":"https://api.githubcopilot.com/mcp","headers":{"Authorization":"Bearer "}}'
```
