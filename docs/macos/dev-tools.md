# Developer Tools

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

Update the `~/.zshrc` file to match `./collected/zshrc`.

## `vim`

### Manage Packages for `vim` Using Vundle and Vundle packages

First, update the `~/.vimrc` file to match the collected file at `./collected/vimrc`.

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
# :PluginInstall
```

## `ripgrep`

Used by Deep Agents and other tooling. Installed via `Brewfile` or:

```bash
brew install ripgrep
```

## Cursor

### Settings Sync (recommended)

Enable Cursor Settings Sync to restore extensions, settings, and keybindings:

- Gear icon → Settings → Sync → Sign in → Enable Sync

### Local extensions backup (repo-friendly)

Export extensions to a repo file and restore them later:

```bash
./scripts/bash/cursor/export-extensions.sh
./scripts/bash/cursor/install-extensions.sh
```

### Local settings/keybindings backup (repo-friendly)

Export settings and keybindings to repo files and restore them later:

```bash
./scripts/bash/cursor/export-settings.sh
./scripts/bash/cursor/install-settings.sh
```

### Allow press and hold in Cursor since I use the `vim` extension

```bash
# Setting to false disables the _Apple_ press and hold, allowing VSCode's to take over.
defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
```

### Install Cursor Extensions (not required if use Settings Sync)

```bash
# Docker
open https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker

# ESLint
open https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint

# Go
open https://code.visualstudio.com/docs/languages/go

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

# Python
open https://marketplace.visualstudio.com/items?itemName=ms-python.python

# vim
open https://marketplace.visualstudio.com/items?itemName=vscodevim.vim

# YAML
open https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
```

## Other

### `npm`

Make sure `npm` is up to date. Install any important global `node` dependencies.

```bash
npm install -g npm-check-updates
npm-check-updates -u
npm install

npm install -g depcheck
npx install

npm install -g @anthropic-ai/claude-code
```

### `pipx`

```bash
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
```
