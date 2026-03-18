# Provisioning a macOS Machine (To My Preferences) Steps

## Log Into iCloud

This is the first step since it will help with syncing all of the settings that I allow it to sync.

## Install Developer Tools

Scripted:

```bash
./scripts/bash/macos/setup.sh
```

Manual (if you want to do it step-by-step):

```bash
xcode-select --install
```

## Log Into Chrome

This should sync all Chrome extensions that will be useful going forward (vimium, Adblock, pin, 1password and other chrome extensions, fix the extensions that actually get installed).

## Log Into Gmail

Logging into email will also be helpful with any future steps that require email auth or finding a vendor license, etc.

## Log Into GitHub

This will help with cloning any repos in the following steps.

Create an SSH key for this new machine and add the output `id_rsa.pub` to [GitHub](https://github.com/settings/keys).

```bash
mkdir ~/.ssh
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

## Setup docs

Use the detailed guides below to finish your setup:

- [Homebrew](./docs/macos/brew.md)
- [Developer tools](./docs/macos/dev-tools.md)
- [Secrets and credentials](./docs/macos/secrets.md)
- [System settings and apps](./docs/macos/system-settings.md)
