#!/bin/bash

# Add the HashiCorp apt-key, repository and update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update

# Install all the clustered HashiCorp tool binaries
sudo apt-get install vault
sudo apt-get install consul
sudo apt-get install nomad
sudo apt-get install terraform
sudo apt-get install waypoint

##########
# CONSUL #
##########

# https://learn.hashicorp.com/tutorials/consul/deployment-guide?in=consul/production-deploy

# The consul command features opt-in autocompletion for flags, subcommands, and arguments (where supported).
consul -autocomplete-install

# Enable autocompletion.
complete -C /usr/bin/consul consul

# Create a unique, non-privileged system user to run Consul and create its data directory.
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul

# Prepare the security credentials

## Generate the gossip encryption key
consul keygen

## Generate TLS certificates for RPC encryption
### Create the Certificate Authority
consul tls ca create

#########
# VAULT #
#########
# TODO

#########
# NOMAD #
#########
# TODO

############
# WAYPOINT #
############
# TODO

############
# BOUNDARY #
############
# TODO
