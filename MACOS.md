# Provisioning a macOS Machine (To My Preferences) Steps

## Log Into iCloud

This is the first step since it will help with syncing all of the settings that I allow it to sync.

## Install Developer Tools

```bash
xcode-select --install
```

## Install Commonly Used Mac Apps

```bash
# 1Password
open https://apps.apple.com/us/app/1password-7-password-manager/id1333542190?mt=12

# 1Password CLI
open https://app-updates.agilebits.com/product_history/CLI

# 24 Hour Wallpaper
open https://apps.apple.com/us/app/24-hour-wallpaper/id1226087575?mt=12

# Docker for Mac
open https://docs.docker.com/docker-for-mac/install/

# Evernote
open https://apps.apple.com/us/app/evernote/id406056744?mt=12

# Gimp
open https://www.gimp.org/downloads/

# Google Chrome
open https://www.google.com/chrome/

# iStat Menus (license key in email)
open https://bjango.com/mac/istatmenus/

# iTerm2
open https://www.iterm2.com/downloads.html

# Keybase
open https://keybase.io/docs/the_app/install_macos

# MacDown
open https://macdown.uranusjr.com/

# Magnet
open https://apps.apple.com/us/app/magnet/id441258766?mt=12

# NordVPN
open https://apps.apple.com/us/app/nordvpn-ike-unlimited-vpn/id1116599239?mt=12

# pgAdmin 4
open https://www.pgadmin.org/download/pgadmin-4-macos/

# Postman
open https://www.postman.com/downloads/

# Slack
open https://apps.apple.com/us/app/slack/id803453959?mt=12

# Spotify
open https://www.spotify.com/us/download/other/

# Steam
open https://store.steampowered.com/macos

# Sublime Text 3
https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg

# Vagrant
open https://www.vagrantup.com/downloads.html

# VirtualBox
open https://www.virtualbox.org/wiki/Downloads

# VS Code
open https://code.visualstudio.com/download

# Zoom
open https://zoom.us/download
```

## Log Into 1Password

Log into the 1Password UI, both work and personal vaults. This will make logging into things much easier. Also set up the 1Password CLI.

```bash
op signin my.1password.com neil.dahlke@gmail.com
eval $(op signin my)

op signin hashicorp.1password.com neil@hashicorp.com
eval $(op signin hashicorp)
```

## Log Into Chrome

This should sync all Chrome extensions that will be useful going forward (vimium, Adblock, pin, 1password and other chrome extensions, fix the extensions that actually get installed).

## Log Into Gmail

Logging into email will also be helpful with any future steps that require email auth or finding a vendor license, etc.

## Log Into GitHub

This will help with cloning any repos in the following steps.

Create an SSH key for this new machine and add the output `id_rsa.pub` to [GitHub](https://github.com/settings/keys).

```bash
cd ~/.ssh
ssh-keygen
```

Create a local directory to store any cloned repos into. Download this repo, so we have a local copy going forward.

```bash
mkdir -p ~/src/github.com/dahlke
cd ~/src/github.com/dahlke
git clone git@github.com:dahlke/eklhad-config.git
```

## `brew`

### Install `brew`

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Update `brew`

```bash
brew update
```

### Install commonly used `brew` packages

```bash
brew cask install 1password
brew install aliyun-cli
brew install autojump
brew install azure-cli
brew install envchain
brew install go
brew install jenv
brew install jq
brew install kubernetes-cli
brew install maven
brew install minikube
brew install node
brew install python
brew install socat
brew install the_silver_searcher
brew install watch
brew install wget
brew install vim
brew install yarn
```

## `zsh`

### Install `zsh`

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Set `zsh` as default shell, create expected files

```bash
chsh -s /usr/local/bin/zsh
mkdir ~/.zsh
touch ~/.zsh/config
```

## `vim`

### Install Vundle and Vundle packages for `vim`

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
# :BundleInstall
```

## VSCode

- [Turn on Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync)
  - Manage -> Turn on Preferences Sync

- Allow `vim` to yank to clipboard
  - File -> Preferences -> Extensions -> Click "useSystemClipboard"
- Remove Trailing Whitespace on Save
  - File -> Preferences -> Settings -> User Settings -> `"files.trimTrailingWhitespace": true`

### Allow press and hold in VSCode since I use the `vim` extension

```bash
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

### Install VSCode Extensions

```bash
# Docker
open https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker

# ESLint
open https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint

# Go
open https://code.visualstudio.com/docs/languages/go

# HCL
open https://marketplace.visualstudio.com/items?itemName=wholroyd.HCL

# Kubernetes
open https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools

# MarkdownLint
open https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint

# MySQl
open https://marketplace.visualstudio.com/items?itemName=formulahendry.vscode-mysql

# Python
open https://marketplace.visualstudio.com/items?itemName=ms-python.python

# Terraform
open https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

# vim
open https://marketplace.visualstudio.com/items?itemName=vscodevim.vim
```

## MacOS

### Finder

- Finder > Preferences > General > Show these items on the desktop > Hard disks
- Finder > neil > Drag `src` directory to the sidebar

## System Preferences

- General
  - Appearance -> Auto
  - Sidebar icon size -> Small
  - Show scroll bars -> When Scrolling
  - Default web browser -> Google Chrome
- Desktop and Screen Saver
  - Hot Corners -> Lock Screen (bottom right corner)
- Dock
  - Small size
  - No magnification
  - Minimize windows using -> Scale effect
  - Automatically hide and show the Dock
- Displays
  - Configure ultra-wide screen above laptop screen
  - Laptop screen main display
- Keyboard
  - Keyboard
    - Key repeat -> Fast
    - Delay until repeat -> Short
    - Modifier Keys -> Microsoft Nano Tranceiver -> (Option = Command, Command = Option)
  - Shortcuts
    - Enable: Use keyboard navigation to move focus between controls
- Trackpad
  - Disable: Scroll direction natural -> disable
  - Enable: Zoom in or out -> pinch with two fingers
  - Enable: Smart zoom -> double-tap with two fingers
  - Enable: Rotate -> rotate with two fingers
- Mouse
  - Disable: Scroll direction natural
  - Enable: Secondary click -> Click on the right side

## iTerm2

iTerm -> General -> Preferences -> Load Preferences from (“`/.iterm”).

## HashiCorp Tools

```bash
export TERRAFORM_VERSION="0.12.26"
export VAULT_VERSION="1.4.2"
export CONSUL_VERSION="1.7.4"
export NOMAD_VERSION="0.11.3"
export PACKER_VERSION="1.6.0"

cd ~/Downloads

wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
sudo mv terraform /usr/local/bin/terraform
rm terraform_${TERRAFORM_VERSION}_darwin_amd64.zip

wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_darwin_amd64.zip
unzip vault_${VAULT_VERSION}_darwin_amd64.zip
sudo mv vault /usr/local/bin/vault
rm vault_${VAULT_VERSION}_darwin_amd64.zip

wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_darwin_amd64.zip
unzip consul_${CONSUL_VERSION}_darwin_amd64.zip
sudo mv consul /usr/local/bin/consul
rm consul_${CONSUL_VERSION}_darwin_amd64.zip

wget https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_darwin_amd64.zip
unzip nomad_${NOMAD_VERSION}_darwin_amd64.zip
sudo mv nomad /usr/local/bin/nomad
rm nomad_${NOMAD_VERSION}_darwin_amd64.zip

wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_darwin_amd64.zip
unzip packer_${PACKER_VERSION}_darwin_amd64.zip
sudo mv packer /usr/local/bin/packer
rm packer_${PACKER_VERSION}_darwin_amd64.zip

terraform version
vault version
consul version
nomad version
packer version
```

## `envchain` Required Setup

### Personal Vault

#### Log into 1Password Personal Vault

```bash
eval $(op signin my)
```

#### Set Personal AWS Creds

```bash
AWS_ACCESS_KEY_ID=$(op get item Amazon | jq -r '.details.sections[1].fields[1].v')
AWS_SECRET_ACCESS_KEY=$(op get item Amazon | jq -r '.details.sections[1].fields[0].v')
echo "AWS_ACCESS_KEY_ID:" $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY:" $AWS_SECRET_ACCESS_KEY
envchain --set aws_eklhad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
export $(envchain aws_eklhad env | grep AWS_)
```

#### Set Personal Cloudflare Creds

```bash
CLOUDFLARE_TOKEN=$(op get item Cloudflare | jq -r '.details.sections[1].fields[0].v')
CLOUDFLARE_EMAIL=$(op get item Cloudflare | jq -r '.details.sections[1].fields[1].v')
CLOUDFLARE_API_KEY=$(op get item Cloudflare | jq -r '.details.sections[1].fields[2].v')
echo "CLOUDFLARE_TOKEN:" $CLOUDFLARE_TOKEN
echo "CLOUDFLARE_EMAIL:" $CLOUDFLARE_EMAIL
echo "CLOUDFLARE_API_KEY:" $CLOUDFLARE_API_KEY
envchain --set cloudflare_eklhad CLOUDFLARE_EMAIL CLOUDFLARE_TOKEN CLOUDFLARE_API_KEY
export $(envchain cloudflare_eklhad env | grep CLOUDFLARE_)
```

#### Set Personal CodeCov Creds

```bash
CODECOV_TOKEN=$(op get item CodeCov | jq -r '.details.sections[1].fields[0].v')
echo "CODECOV_TOKEN:" $CODECOV_TOKEN
envchain --set codecov_eklhad CODECOV_TOKEN
export $(envchain codecov_eklhad env | grep CODECOV_)
```

#### Set Personal Sendgrid (SMTP) Creds

```bash
SMTP_HOST=$(op get item Sendgrid | jq -r '.details.sections[1].fields[0].v')
SMTP_PORT=$(op get item Sendgrid | jq -r '.details.sections[1].fields[1].v')
SMTP_USERNAME=$(op get item Sendgrid | jq -r '.details.sections[1].fields[2].v')
SMTP_PASSWORD=$(op get item Sendgrid | jq -r '.details.sections[1].fields[3].v')
echo "SMTP_HOST:" $SMTP_HOST
echo "SMTP_PORT:" $SMTP_PORT
echo "SMTP_USERNAME:" $SMTP_USERNAME
echo "SMTP_PASSWORD:" $SMTP_PASSWORD
envchain --set sendgrid_eklhad SMTP_HOST SMTP_PORT SMTP_USERNAME SMTP_PASSWORD
export $(envchain sendgrid_eklhad env | grep SMTP_)
```

#### Set Personal GitHub Creds

```bash
GITHUB_TOKEN=$(op get item GitHub | jq -r '.details.sections[1].fields[0].v')
GITHUB_SECRET=$(op get item GitHub | jq -r '.details.sections[1].fields[1].v')
echo "GITHUB_TOKEN:" $GITHUB_TOKEN
echo "GITHUB_SECRET:" $GITHUB_SECRET
envchain --set github_eklhad GITHUB_TOKEN GITHUB_SECRET
export $(envchain github_eklhad env | grep GITHUB_)
```

#### Set Personal Twilio Creds

```bash
TWILIO_ACCOUNT_SID=$(op get item Twilio | jq -r '.details.sections[1].fields[0].v')
TWILIO_AUTH_TOKEN=$(op get item Twilio | jq -r '.details.sections[1].fields[1].v')
echo "TWILIO_ACCOUNT_SID:" $TWILIO_ACCOUNT_SID
echo "TWILIO_AUTH_TOKEN:" $TWILIO_AUTH_TOKEN
envchain --set twilio_eklhad TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN
export $(envchain twilio_eklhad env | grep TWILIO_)
```

#### Set Personal Terraform Cloud Creds

```bash
TFC_URL="https://app.terraform.io"
TFC_TOKEN=$(op get item "Terraform Cloud" | jq -r '.details.sections[1].fields[0].v')
echo "TFC_URL:" $TFC_URL
echo "TFC_TOKEN:" $TFC_TOKEN
envchain --set tfc_eklhad TFC_URL TFC_TOKEN
export $(envchain tfc_eklhad env | grep TFC_)
```

#### Set Personal Azure Creds

```bash
# TODO
envchain --set azure_eklhad ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID ARM_TENANT_ID
```

#### Set Personal GCP Creds

```bash
# TODO
envchain --set gcp_eklhad GOOGLE_CREDENTIALS
```

### Work Vault

#### Log into 1Password Work Vault

```bash
eval $(op signin hashicorp)
```

#### Set Work AWS Creds

```bash
AWS_ACCESS_KEY_ID=$(op get item Amazon | jq -r '.details.sections[1].fields[0].v')
AWS_SECRET_ACCESS_KEY=$(op get item Amazon | jq -r '.details.sections[1].fields[1].v')
echo "AWS_ACCESS_KEY_ID:" $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY:" $AWS_SECRET_ACCESS_KEY
envchain --set aws_hashi AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
export $(envchain aws_hashi env | grep AWS_)
```

#### Set Work Alibaba Cloud Creds

```bash
ALICLOUD_ACCESS_KEY=$(op get item "Alibaba Cloud" | jq -r '.details.sections[1].fields[0].v')
ALICLOUD_SECRET_KEY=$(op get item "Alibaba Cloud" | jq -r '.details.sections[1].fields[1].v')
echo "ALICLOUD_ACCESS_KEY:" $ALICLOUD_ACCESS_KEY
echo "ALICLOUD_SECRET_KEY:" $ALICLOUD_SECRET_KEY
envchain --set ali_hashi ALICLOUD_ACCESS_KEY ALICLOUD_SECRET_KEY
export $(envchain ali_hashi env | grep AWS_)
aliyun configure
```

#### Set Work Azure Creds

```bash
# TODO
envchain --set azure_hashi ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID ARM_TENANT_ID
```

#### Set Work GCP Creds

```bash
# TODO
envchain --set gcp_hashi GOOGLE_CREDENTIALS
```

#### Set Work TFC Creds

```bash
TFC_URL="https://app.terraform.io"
TFC_TOKEN=$(op get item "Terraform Cloud" | jq -r '.details.sections[1].fields[0].v')
echo "TFC_URL:" $TFC_URL
echo "TFC_TOKEN:" $TFC_TOKEN
envchain --set tfc_hashi TFC_URL TFC_TOKEN
export $(envchain tfc_hashi env | grep TFC_)
```

#### Set Work TFE Creds

```bash
TFC_URL="<TFE_URL>"
TFC_TOKEN="<TFE_TOKEN>"
echo "TFC_URL:" $TFC_URL
echo "TFC_TOKEN:" $TFC_TOKEN
envchain --set tfe_hashi TFC_URL TFC_TOKEN
export $(envchain tfe_hashi env | grep TFC_)
```

#### Set Work Local Vault Creds

```bash
VAULT_ADDR="http://localhost:8200"
VAULT_TOKEN="root"
echo "VAULT_ADDR:" $VAULT_ADDR
echo "VAULT_TOKEN:" $VAULT_TOKEN
envchain --set local_vault VAULT_ADDR VAULT_TOKEN
export $(envchain local_vault env | grep VAULT_)
```

## Other

### `jenv`

Fix any existing issues. Useful for any Java work that comes up.

```bash
jenv doctor
```

### `npm`

Make sure `npm` is up to date. Install any important global `node` dependencies.

```bash
npm install -g npm-check-updates
npm-check-updates -u
npm install
```

### `pip3`

Install any important global `python3` dependencies.

```bash
pip3 install virtualenv
```
