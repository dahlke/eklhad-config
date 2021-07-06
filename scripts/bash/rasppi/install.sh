#!/bin/bash

##################
# COMMON INSTALL #
##################

# TODO: handle specific versions
# Add the HashiCorp apt-key, repository and update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update

# Install all the clustered HashiCorp tool binaries
sudo apt-get install vault
sudo apt-get install consul
sudo apt-get install nomad
sudo apt-get install boundary
sudo apt-get install waypoint
sudo apt-get install terraform


# TODO: Setup and run all the services we just installed.
