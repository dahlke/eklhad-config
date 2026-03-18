# Secrets and Credentials

## Log Into 1Password

Log into the 1Password UI. This will make logging into things much easier. Also set up the 1Password CLI. Example below:

```bash
op signin my.1password.com neil.dahlke@gmail.com
eval $(op signin my)
```

## Secrets file

Use `static/secrets.op.sh` as the template for secret exports. Copy it to
`~/.secrets.op.sh`, adjust values as needed, and source it after signing in:

```bash
source ~/.secrets.op.sh
```

If you want a clean starting point, use `static/secrets.op.sh.example` instead.
Avoid committing local secret files.

## Credentials

### Personal Vault

#### Log into 1Password Personal Vault

```bash
eval $(op signin my)
```

#### Set Personal Cloudflare Creds

```bash
export CLOUDFLARE_TOKEN=$(op get item Cloudflare | jq -r '.details.sections[1].fields[0].v')
export CLOUDFLARE_EMAIL=$(op get item Cloudflare | jq -r '.details.sections[1].fields[1].v')
export CLOUDFLARE_API_KEY=$(op get item Cloudflare | jq -r '.details.sections[1].fields[2].v')
```

#### Set Personal CodeCov Creds

```bash
export CODECOV_TOKEN=$(op get item CodeCov | jq -r '.details.sections[1].fields[0].v')
```

#### Set Personal GitHub Creds

```bash
export GITHUB_TOKEN=$(op get item GitHub | jq -r '.details.sections[1].fields[0].v')
export GITHUB_SECRET=$(op get item GitHub | jq -r '.details.sections[1].fields[1].v')
```

#### Set Personal GCP Creds

```bash
export GOOGLE_CREDENTIALS=$(op get item "Google dahlke.io" | jq -r '.details.sections[1].fields[0].v' | jq -r .)
```
