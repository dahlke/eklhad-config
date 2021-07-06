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
sudo apt-get install -y vault
sudo apt-get install -y consul
sudo apt-get install -y nomad
sudo apt-get install -y boundary
sudo apt-get install -y waypoint
sudo apt-get install -y terraform


# TODO: Setup and run all the services we just installed.
