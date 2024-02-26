# Provisioning an Ubuntu Machine (To My Preferences) Steps

- Install the minimal version

## Install 1Password

```bash
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/

curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update && sudo apt install 1password
```

## Log In to Cloud Services

### Google

TODO

## `git`

### Install `git`

```bash
TODO
```

### Configure `git`

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

# TODO

- Change the mouse settings to rework the direction
	- Settings -> Mouse & Touchpad -> Natural Scrolling (On)
- Figure out how to change the CTRL-C / CTRL-V
- Quick lookup tool like Finder
- Install git
- Install Chrome
- Install VLC
- Install VSCode
- Install Zoom
