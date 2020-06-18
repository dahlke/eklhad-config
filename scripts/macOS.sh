#!/bin/bash

# `brew`

## Install `brew`

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## Update `brew`
```
brew update
```

## Install commonly used `brew` packages

```
brew install autojump
brew install azure-cli
brew install jq
brew install kubernetes-cli
brew install minikube
brew install go
brew install python
brew install socat
brew install the_silver_searcher
brew install vim
brew install watch
brew install wget
brew install envchain
brew install jenv
```

# `zsh`

## Install `zsh`
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Set `zsh` as default shell, create expected files.
```
chsh -s /usr/local/bin/zsh
mkdir ~/.zsh
touch ~/.zsh/config
```

# `vim`

## Install Vundle and Vundle packages for `vim`
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim 
# :BundleInstall
```

# VSCode

## Allow VSCode `vim` to yank to clipboard, 

```
code .
# extension preferences and click `useSystemClipboard`.
```

## Allow press and hold in VSCode since I use the `vim` extension.

```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# TODO: why is it escaping on paste
```

# Mac Application Downloads

```
# iTerm2
open https://www.iterm2.com/downloads.html

# Google Chrome
open https://www.google.com/chrome/

# VS Code
open https://code.visualstudio.com/download

# Sublime Text 3
https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg

# Docker for Mac
open https://docs.docker.com/docker-for-mac/install/

# Gimp
open https://www.gimp.org/downloads/

# Keybase
open https://keybase.io/docs/the_app/install_macos

# iStat Menus (license key in email)
open https://bjango.com/mac/istatmenus/

# Evernote
open https://apps.apple.com/us/app/evernote/id406056744?mt=12

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

# VirtualBox
open https://www.virtualbox.org/wiki/Downloads

# 1Password
open https://apps.apple.com/us/app/1password-7-password-manager/id1333542190?mt=12

# 24 Hour Wallpaper
open https://apps.apple.com/us/app/24-hour-wallpaper/id1226087575?mt=12

# Spotify
open https://www.spotify.com/us/download/other/

# Vagrant
open https://www.vagrantup.com/downloads.html
```

# HashiCorp Tools

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
```

# Install Java Versions

```
jenv doctor
```

# Required Logins (Other apps need login, but these will help smooth out the provisioning experience)
- iCloud
- Chrome
- Google (all accounts)
- 1Password
- GitHub
- Keybase

# Required Config
- TODO: any prefs from config script
- everything `envchain`