#!/bin/bash

# Base install steps for Raspberry Pi nodes.

set -e

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
  curl \
  git \
  htop \
  jq \
  net-tools \
  rsync \
  tmux \
  ufw \
  unzip \
  vim \
  wget

if ! command -v fail2ban-client >/dev/null 2>&1; then
  sudo apt-get install -y fail2ban
fi

if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow OpenSSH
  sudo ufw --force enable
fi
