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

##Allow VSCode `vim` to yank to clipboard, 

```
code .
# extension preferences and click `useSystemClipboard`.
```

## Allow press and hold in VSCode since I use the `vim` extension.

```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool true
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