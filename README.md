# Eklhad Config

A tool to gather your configurations and store them here so you can migrate personal machines more easily. Mine are in the `collected/` dir here as an example and also for my own easy access.

### Usage
To collect all of the files you need, use the `figo.py` script, which will collect all files listed in `config/files.json`:

```
$ ./figo.py --collect
```

To apply all the files on the other side, use the apply command.
```
$ ./figo.py --apply
```

## Provisioning a New macOS Machine Steps
- Log into iCloud
- Download all apps from scripts/macOS.sh
- Log into Chrome
    - This should sync all Chrome extensions that will be useful going forward (vimium, Adblock, pin, 1password and other chrome extensions, fix the extensions that actually get installed).
- Log into Gmail
    - Logging into email will also be helpful with any future steps that require email auth or finding a vendor license, etc. 
- Log into 1Password
    - Personal 1Password
    - Work 1Password
- Log into GitHub
    - Set SSH key for new machine in GitHub
        - `mkdir ~/.ssh`
        - `cd ~/.ssh`
        - `ssh-keygen -t rsa -b 4096 -C "neil.dahlke@gmail.com"`
        - `cat ~/.ssh/id_rsa.pub`
        - Add the key https://github.com/settings/keys
- Make local src directory for all source code, then clone helpful set up repos, run the apply 
    - `mkdir -p ~/src/github.com/dahlke`
    - `cd ~/src/github.com/dahlke`
    - `git clone git@github.com:dahlke/eklhad-config.git`
    - `cd eklhad-config`
    - `./figo.py --apply`
- Configure common apps
    - iTerm
        - iTerm -> General -> Preferences -> Load Preferences from (“`/.iterm”)
            - Open eklhad-config, install the MacOs apps
    - vim
        - `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
        - TODO: Vundle install
    - zsh (set as default shell)
        - `chsh -s /usr/local/bin/zsh`

### HashiCorp Tools
```
https://www.vaultproject.io/downloads
https://www.terraform.io/downloads.html
https://www.consul.io/downloads
https://www.nomadproject.io/downloads/
https://www.packer.io/downloads
https://www.vagrantup.com/downloads.html
```

### TODO: VS Code extensions


### `envchain` Required Setup
```
envchain --set aws_hashi AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
envchain --set aws_eklhad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
envchain --set ali_hashi ALICLOUD_ACCESS_KEY ALICLOUD_SECRET_KEY
envchain --set local_vault VAULT_ADDR VAULT_TOKEN
envchain --set sendgrid_eklhad SMTP_HOST SMTP_PORT SMTP_USERNAME SMTP_PASSWORD
envchain --set github_eklhad GITHUB_TOKEN GITHUB_SECRET
envchain --set twilio_eklhad TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN
envchain --set codecov_eklhad CODECOV_TOKEN
envchain --set tfc_hashi TFC_URL TFC_TOKEN
envchain --set tfe_hashi TFC_URL TFC_TOKEN
envchain --set tfc_eklhad TFC_URL TFC_TOKEN
envchain --set cloudflare_eklhad CLOUDFLARE_EMAIL CLOUDFLARE_TOKEN CLOUDFLARE_API_KEY
```

### `envchain` Example Usage
```
# List all namespaces
envchain --list | sort | uniq -c

# Set a namespace's env vars
export $(envchain aws_hashi env | grep AWS_)

# Require MacOS auth
envchain --set --require-passphrase aws_hashi
```

### Hashi Tools
```
```

### TODO
- MacOS Frequent Apps
- MacOS Keyboard Preferences
- MacOS Mouse Preferences
- MacOS Display Preferences
- VSCode Config
- .azure/ profile contents
- .gcp/ profile contents



```
# Remaining items

- mkdir ~/.zsh
- touch ~/.zsh/config
- Does 1P have a CLI?
- Update Zshrc in eklhad-config
- VSCode extensions auto install
- Change copy buffer in VSCode to be shared.
- Install java / jenv
- Figure out which apps I can use brew with (MacDown for ex)
- Review the order of all the steps
    - Change iStat Menus to https://bjango.com/mac/istatmenus/ since it wasn’ bought through the App Store
- Env chain environment variables
    - Make sure they sync across devices
```