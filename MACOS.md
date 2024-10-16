# Provisioning a macOS Machine (To My Preferences) Steps

## Log Into iCloud

This is the first step since it will help with syncing all of the settings that I allow it to sync.

## Install Developer Tools

```bash
xcode-select --install
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

## `brew`

### Install `brew`

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Update `brew`

```bash
brew update
```

### Install Commonly Used Tools and Apps via `brew`

```bash
brew install --cask 1password
brew install --cask 1password-cli
brew install aliyun-cli
brew install asdf
brew install autojump
brew install azure-cli
brew install awscli
brew install caddy
brew install certstrap
brew install --cask chatgpt
brew install chromium
brew install csshx
brew install --cask cursor
brew install derailed/k9s/k9s
brew install --cask discord
# brew install eksctl
brew install --cask evernote
brew install ffmpeg
brew install fig
brew install gcc
# brew install --cask gimp
brew install gh
brew install go
brew install --cask google-chrome
brew install --cask google-drive
brew install gpg
brew install gradle
brew install grafana
brew install graphviz
brew install --cask graphql-playground
brew install helm
brew install htop
brew install --cask istat-menus
brew install --cask iterm2
brew install jenv
brew install jq
brew install --cask keybase
brew install kind
brew install kubernetes-cli
brew install maven
brew install --cask microsoft-edge
brew install --cask microsoft-teams
brew install minikube
brew install nmap
brew install node
# brew install --cask nordvpn
brew install opa
brew install --cask postman
brew install --cask pgadmin4
brew install pipx
brew install pnpm
brew install postgresql
brew install python
brew install rustup # rustup-init
brew install --cask signal
brew install --cask slack
brew install socat
brew install --cask spotify
brew install --cask steam
brew install --cask sublime-text
brew install the_silver_searcher
brew install temporal
brew install tree
brew install --cask qflipper
brew install watch
brew install watchman
brew install --cask webex
brew install wrk
brew install wget
brew install --cask vagrant
brew install vim
brew install --cask virtualbox
brew install --cask vlc
brew install xaf/omni/omni
# brew install yarn
brew install --cask zoom

brew tap temporalio/brew
brew install tctl
brew install tcld
brew install temporalio/brew/tcld

brew tap hashicorp/tap
brew install hashicorp/tap/boundary
brew install hashicorp/tap/consul
brew install hashicorp/tap/nomad
brew install hashicorp/tap/packer
brew install hashicorp/tap/terraform
brew install hashicorp/tap/vault
brew install hashicorp/tap/waypoint
brew install vlt

brew tap mike-engel/jwt-cli
brew install jwt-cli

brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
```

### Install Any Remaining Commonly Used Tools and Apps

[GCP SDK Quickstart MacOS](https://cloud.google.com/sdk/docs/quickstart-macos)

_TODO: use a variable for the version. Need to log in to complete the init._

```bash
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz
tar xf google-cloud-cli-darwin-x86_64.tar.gz
cd google-cloud-sdk/
./install.sh
source ~/.zshrc
gcloud init
cd ../
rm -rf google-cloud-sdk-372.0.0-darwin-x86_64.tar.gz
```

Install [`golint`](https://pkg.go.dev/golang.org/x/lint/golint).

```bash
go get -u golang.org/x/lint/golint
```

## Install Commonly Used Mac Apps

```bash
# Docker for Mac
open https://docs.docker.com/docker-for-mac/install/

# LogiTune
open https://support.logi.com/hc/en-us/articles/360024361233

# Magnet
open https://apps.apple.com/us/app/magnet/id441258766?mt=12

# VS Code Insiders
open https://code.visualstudio.com/insiders/
```

## Log Into 1Password

Log into the 1Password UI, both work and personal vaults. This will make logging into things much easier. Also set up the 1Password CLI.

```bash
op signin my.1password.com neil.dahlke@gmail.com
eval $(op signin my)

op signin team-temporal.1password.com neil.dahlke@temporal.io
eval $(op signin temporal)
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

Set up the standard Git user data.

```bash
git config --global user.email neil.dahlke@gmail.com
git config --global user.name "Neil Dahlke"
```

Create a local directory to store any cloned repos into. Download this repo, so we have a local copy going forward.

```bash
mkdir -p ~/src/github.com/dahlke
cd ~/src/github.com/dahlke
git clone git@github.com:dahlke/eklhad-config.git
```

## `vim`

### Manage Packages for `vim` Using Vundle and Vundle packages

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
# :PluginInstall
```

## VS Code

- [Turn on Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync)
  - Manage -> Turn on Preferences Sync
  - Allow the preferences to sync

### Allow press and hold in VSCode since I use the `vim` extension

```bash
# Setting to false disables the _Apple_ press and hold, allowing VSCode's to take over.
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
```

### Install VSCode Extensions (not required if use Settings Sync)

```bash
# Docker
open https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker

# ESLint
open https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint

# Go
open https://code.visualstudio.com/docs/languages/go

# GraphQL
open https://marketplace.visualstudio.com/items?itemName=GraphQL.vscode-graphql

# HashiCorp Configuration Language
https://marketplace.visualstudio.com/items?itemName=HashiCorp.HCL

# HashiCorp Terraform
open https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

# Jupyter
open https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter

# Kubernetes
open https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools

# MarkdownLint
open https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint

# MySQL
open https://marketplace.visualstudio.com/items?itemName=formulahendry.vscode-mysql

# PostCSS
open https://marketplace.visualstudio.com/items?itemName=csstools.postcss

# Python
open https://marketplace.visualstudio.com/items?itemName=ms-python.python

# vim
open https://marketplace.visualstudio.com/items?itemName=vscodevim.vim

# YAML
open https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
```

## MacOS

### Finder

- Finder > Preferences > General > Show these items on the desktop > Hard disks
- Finder > neil > Drag `src` directory to the sidebar

## System Preferences

- Appearance
  - Appearance -> Auto
  - Sidebar icon size -> Small
  - Show scroll bars -> When Scrolling
- Desktop and Dock
  - Small size
  - No magnification
  - Minimize windows using -> Scale effect
  - Automatically hide and show the Dock
  - Default web browser -> Google Chrome
- Displays
  - Configure external monitors
- Keyboard
  - Keyboard
    - Key repeat -> Fast
    - Delay until repeat -> Short
    - Modifier Keys -> Microsoft Nano Tranceiver -> (Option = Command, Command = Option)
  - Shortcuts
    - Enable: Use keyboard navigation to move focus between controls
    - All Applications
      - Lock Screen = `Option + Command + L`
    - Mission Control
      - Show Desktop = `Shift + Command + \`
    - App Shortcuts
      - "Messages -> Delete Conversation..." = `Shift + Command + D`
      - "iTerm -> Clear Buffer" = `Command + E`
    - Screenshots
      - Disable Save picture of screen as file
      - Disable Copy picture of screen to the clipboard
- Trackpad
  - Disable: Scroll direction natural -> disable
  - Enable: Smart zoom -> double-tap with two fingers
- Mouse
  - Disable: Scroll direction natural
  - Enable: Secondary click -> Click on the right side
- Notifications
  - Facetime
    - Disable: Play sound for notifications

## iTerm2

### Load the Personal Profile

- iTerm
  - General
    - Preferences
      - Load Preferences from `./collected/eklhad_iterm.json`

### Setup Appearance

- iTerm
  - Appearance
    - General
      - Theme = Dark
      - Tab bar = Top
      - Status bar = Top
      - General Auto-Hide menu bar in non-native fullscreen

### Setup Key Bindings

- iTerm
  - Keys
    - Select Split Plane on Left = `Command + H`
    - Select Split Plane on Right = `Command + H`
    - Select Split Plane Above = `Command + K`
    - Select Split Plane Below = `Command + J`

## Magnet

- Magnet
  - Preferences
    - Left = `Shift + Command + H`
    - Right = `Shift + Command + L`
    - Up = `Shift + Command + K`
    - Down = `Shift + Command + J`
    - Left Third = `Shift + Command + 1`
    - Center Third = `Shift + Command + 2`
    - Right Third = `Shift + Command + 3`
    - Next Display = `Control + Shift + Command + 1`
    - Previous Display = `Control + Shift + Command + 1`
    - Maximize = `Shift + Command + M`
    - Enable launch on login

## Messages

Be sure to setup [text message forwarding](https://support.apple.com/en-us/HT208386) from iPhone, and disable sound effects.

## iStat Menus

Apply the license from email, and then enable: Notifications, CPU & CPU, Memory, Disks, Network and Battery/Power. Start on bootup.

-

## Removed Unused Mac Apps

At this stage, start to remove the applications that you will not use as they are just clutter.

## Credentials

### Personal Vault

#### Log into 1Password Personal Vault

```bash
eval $(op signin my)
```

#### Set Personal AWS Creds

```bash
export AWS_ACCESS_KEY_ID=$(op get item Amazon | jq -r '.details.sections[1].fields[1].v')
export AWS_SECRET_ACCESS_KEY=$(op get item Amazon | jq -r '.details.sections[1].fields[0].v')
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

#### Set Personal Twilio Creds

```bash
export TWILIO_ACCOUNT_SID=$(op get item Twilio | jq -r '.details.sections[1].fields[0].v')
export TWILIO_AUTH_TOKEN=$(op get item Twilio | jq -r '.details.sections[1].fields[1].v')
```

#### Set Personal Terraform Cloud Creds

```bash
export TFC_URL="https://app.terraform.io"
export TFC_TOKEN=$(op get item "Terraform Cloud" | jq -r '.details.sections[1].fields[0].v')
```

#### Set Personal GCP Creds

```bash
export GOOGLE_CREDENTIALS=$(op get item "Google dahlke.io" | jq -r '.details.sections[1].fields[0].v' | jq -r .)
```

## Other

### `asdf`

Inspect available Java versions.

```bash
asdf plugin-add java
asdf list-all java
```

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

npm install -g depcheck
npx install
```

### `pipx`

```bash
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
```

### `poetry`

```bash
pipx install poetry
pipx upgrade poetry
pipx install virtualenv
pipx upgrade virtualenv
```

```bash
poetry completions zsh > ~/.zfunc/_poetry
fpath+=~/.zfunc
autoload -Uz compinit && compinit
```
