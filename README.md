# Eklhad Config

A tool to gather your configurations and store them here so you can migrate personal machines more easily. Mine are in the `collected/` dir here as an example and also for my own easy access.


### Usage
To collect all of the files you need, use the `figo.py` script, which will collect all files listed in `config/files.json`:

```
$ ./figo.py --collect
```

# `envchain` Required Setup
```
envchain --set aws_hashi AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
envchain --set aws_eklhad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
envchain --set ali_hashi ALICLOUD_ACCESS_KEY ALICLOUD_SECRET_KEY
envchain --set local_vault VAULT_ADDR VAULT_TOKEN
envchain --set sendgrid_eklhad SMTP_HOST SMTP_PORT SMTP_USERNAME SMTP_PASSWORD
envchain --set github_eklhad GITHUB_TOKEN GITHUB_SECRET
envchain --set twilio_eklhad TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN
envchain --set codecov_eklhad CODECOV_TOKEN
envchain --set tfc_hashi TFC_HOSTNAME TFC_TOKEN
envchain --set tfe_hashi TFC_HOSTNAME TFC_TOKEN
envchain --set tfc_eklhad TFC_HOSTNAME TFC_TOKEN
envchain --set cloudflare_eklhad CLOUDFLARE_EMAIL CLOUDFLARE_TOKEN CLOUDFLARE_API_KEY
```

# `envchain` Example Usage
```
# List all namespaces
envchain --list | sort | uniq -c

# Set a namespace's env vars
export $(envchain aws_hashi env | grep AWS_)

# Require MacOS auth
envchain --set --require-passphrase aws_hashi
```

### TODO
- MacOS Frequent Apps
- MacOS Keyboard Preferences
- MacOS Mouse Preferences
- MacOS Display Preferences
- VSCode Config
- .azure/ profile contents
- .gcp/ profile contents
