# Provisioning a New macOS Machine Steps

## Log Into iCloud

This is the first step since it will help with syncing all of the settings that I allow it to sync. 

## Install Developer Tools

```
xcode-select --install
```

## Install Commonly Used Mac Apps

```
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

```
op signin my.1password.com neil.dahlke@gmail.com
eval $(op signin my)

op signin hashicorp.1password.com neil@hashicorp.com
eval $(op signin hashicorp)
```

TODO: set up the CLI.

## Log Into Chrome

This should sync all Chrome extensions that will be useful going forward (vimium, Adblock, pin, 1password and other chrome extensions, fix the extensions that actually get installed).

## Log Into Gmail

Logging into email will also be helpful with any future steps that require email auth or finding a vendor license, etc. 

## Log Into GitHub

This will help with cloning any repos in the following steps. 

Create an SSH key for this new machine and add the output `id_rsa.pub` to [GitHub](https://github.com/settings/keys).

```
cd ~/.ssh
ssh-keygen
```


Create a local directory to store any cloned repos into. 

```
mkdir -p ~/src/github.com/dahlke
cd ~/src/github.com/dahlke
git clone git@github.com:dahlke/eklhad-config.git
```

TODO: `eklhad-config` and `./figo.py --apply`.

## `brew`

### Install `brew`

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Update `brew`
```
brew update
```

### Install commonly used `brew` packages

```
brew cask install 1password
brew install autojump
brew install azure-cli
brew install envchain
brew install go
brew install jenv
brew install jq
brew install kubernetes-cli
brew install maven
brew install minikube
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
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Set `zsh` as default shell, create expected files.
```
chsh -s /usr/local/bin/zsh
mkdir ~/.zsh
touch ~/.zsh/config
```

## `vim`

### Install Vundle and Vundle packages for `vim`
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim 
# :BundleInstall
```

## VSCode

### Allow VSCode `vim` to yank to clipboard, 

```
code .
# extension preferences and click `useSystemClipboard`.
```

### Allow press and hold in VSCode since I use the `vim` extension.

```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# TODO: why is it escaping on paste
```

TODO: install all VSCode extensions

## `eklhad-config`

Clone the `eklhad-config` repo into the correct repo. Will be needed to apply some more preferences.

TODO: move this up and outline what it will do. 


## iTerm2

iTerm -> General -> Preferences -> Load Preferences from (“`/.iterm”).


## HashiCorp Tools

```
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

### `envchain` Required Setup

TODO: integrate this with 1Password.

```
# Log into 1 Password
eval $(op signin my)

# Set personal AWS creds from 1Password
AWS_ACCESS_KEY_ID=$(op get item Amazon | jq -r '.details.sections[1].fields[1].v')
AWS_SECRET_ACCESS_KEY=$(op get item Amazon | jq -r '.details.sections[1].fields[0].v')
echo "AWS_ACCESS_KEY_ID:" $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY:" $AWS_SECRET_ACCESS_KEY
envchain --set aws_eklhad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

# Set personal Cloudflare creds from 1Password
CLOUDFLARE_TOKEN=$(op get item Cloudflare | jq -r '.details.sections[1].fields[0].v')
CLOUDFLARE_EMAIL=$(op get item Cloudflare | jq -r '.details.sections[1].fields[1].v')
CLOUDFLARE_API_KEY=$(op get item Cloudflare | jq -r '.details.sections[1].fields[2].v')
echo "CLOUDFLARE_TOKEN:" $CLOUDFLARE_TOKEN
echo "CLOUDFLARE_EMAIL:" $CLOUDFLARE_EMAIL
echo "CLOUDFLARE_API_KEY:" $CLOUDFLARE_API_KEY
envchain --set cloudflare_eklhad CLOUDFLARE_EMAIL CLOUDFLARE_TOKEN CLOUDFLARE_API_KEY

# Set personal CodeCov creds from 1Password
CODECOV_TOKEN=$(op get item CodeCov | jq -r '.details.sections[1].fields[0].n')
echo "CODECOV_TOKEN:" $CODECOV_TOKEN
envchain --set codecov_eklhad CODECOV_TOKEN

# Set personal Sendgrid creds from 1Password
SMTP_HOST=$(op get item Sendgrid | jq -r '.details.sections[1].fields[0].v')
SMTP_PORT=$(op get item Sendgrid | jq -r '.details.sections[1].fields[1].v')
SMTP_USERNAME=$(op get item Sendgrid | jq -r '.details.sections[1].fields[2].v')
SMTP_PASSWORD=$(op get item Sendgrid | jq -r '.details.sections[1].fields[3].v')
echo "SMTP_HOST:" $SMTP_HOST
echo "SMTP_PORT:" $SMTP_PORT
echo "SMTP_USERNAME:" $SMTP_USERNAME
echo "SMTP_PASSWORD:" $SMTP_PASSWORD
envchain --set sendgrid_eklhad SMTP_HOST SMTP_PORT SMTP_USERNAME SMTP_PASSWORD

# Set personal Cloudflare creds from 1Password
GITHUB_TOKEN=$(op get item GitHub | jq -r '.details.sections[1].fields[0].v')
GITHUB_SECRET=$(op get item GitHub | jq -r '.details.sections[1].fields[1].v')
echo "GITHUB_TOKEN:" $GITHUB_TOKEN
echo "GITHUB_SECRET:" $GITHUB_SECRET
envchain --set github_eklhad GITHUB_TOKEN GITHUB_SECRET

# Set personal Cloudflare creds from 1Password
TWILIO_ACCOUNT_SID=$(op get item Twilio | jq -r '.details.sections[1].fields[0].v')
TWILIO_AUTH_TOKEN=$(op get item Twilio | jq -r '.details.sections[1].fields[1].v')
echo "TWILIO_ACCOUNT_SID:" $TWILIO_ACCOUNT_SID
echo "TWILIO_AUTH_TOKEN:" $TWILIO_AUTH_TOKEN
envchain --set twilio_eklhad TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN

# Set personal Cloudflare creds from 1Password
TFC_URL="https://app.terraform.io"
TFC_TOKEN=$(op get item "Terraform Cloud" | jq -r '.details.sections[1].fields[0].v')
echo "TFC_URL:" $TFC_URL
echo "TFC_TOKEN:" $TFC_TOKEN
envchain --set tfc_eklhad TFC_URL TFC_TOKEN

# Set Hashi Creds
envchain --set aws_hashi AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
envchain --set ali_hashi ALICLOUD_ACCESS_KEY ALICLOUD_SECRET_KEY
envchain --set tfc_hashi TFC_URL TFC_TOKEN
envchain --set tfe_hashi TFC_URL TFC_TOKEN
envchain --set local_vault VAULT_ADDR VAULT_TOKEN
```

## Other

### `java`

Fix any existing issues.
```
jenv doctor
```

#### Install the latest Java version from Oracle

```
# Open the page, download whatever is the latest. 
open https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html

# List everything installed
ls /Library/Java/JavaVirtualMachines/

# Make sure the macOS system version of java is in my jenv shims, example:
jdk-14.0.1.jdk

# Add the latest one just installed
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home/
```


### TODO
- MacOS Frequent Apps
- MacOS Keyboard Preferences
- MacOS Mouse Preferences
- MacOS Display Preferences
- VSCode Config
- .azure/ profile contents
- .gcp/ profile contents
- Configure iState Menus
- Update Zshrc in eklhad-config
- VSCode extensions auto install
- Install java / jenv
- Figure out which apps I can use brew with (MacDown for ex)
- Update desktop icon size / clustering settings
- CMD + SHIFT + . to show dotfiles
- gitconfig author / email etc
- Any global pip, npm deps I missed
- iStats Menus
- MacOS Keyboard, enable tab through prompts. 
- Screen shots of System Prefs
- https://www.chaseadams.io/posts/show-your-hard-drive-on-your-desktop-macos/#:~:text=Show%20Macintosh%20HD%20on%20Desktop&text=If%20%E2%80%9CGeneral%E2%80%9D%20isn't,icon%20for%20your%20Macintosh%20HD.

$ npm install -g npm-check-updates
$ npm-check-updates -u
$ npm install