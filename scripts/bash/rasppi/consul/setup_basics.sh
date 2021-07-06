#!/bin/bash

# NOTE: Binary installation in install.sh

echo "Installing Consul auto-completion..."
consul -autocomplete-install
complete -C /usr/bin/consul consul

echo "Creating a unique, non-privileged system user to run Consul and creating a data directory..."
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul

exit 0
