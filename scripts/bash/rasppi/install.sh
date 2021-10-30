#!/bin/bash

# TODO: handle specific versions
CONSUL_VERSION="1.10.3"
VAULT_VERSION="1.8.4"
NOMAD_VERSION="1.1.6"
TERRAFORM_VERSION="1.0.10"
PACKER_VERSION="1.7.8"

# NOTE: Nothing for these distributions for the architectures on the Pis
BOUNDARY_VERSION="0.6.2"
WAYPOINT_VERSION="0.6.1"

##################
# COMMON INSTALL #
##################

# https://releases.hashicorp.com/consul/
# https://releases.hashicorp.com/vault/
# https://releases.hashicorp.com/nomad/
# https://releases.hashicorp.com/terraform/
# https://releases.hashicorp.com/packer/
# https://releases.hashicorp.com/boundary/
# https://releases.hashicorp.com/waypoint/

sudo apt-get install unzip

# NOTE: My Raspberry Pis have different architectures.
architecture=$(uname -a | awk '{print $14}')
echo $architecture

if [ "$architecture" == "armv7l" ]; then
	# Install Consul
	wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_armhfv6.zip
	unzip -o consul_${CONSUL_VERSION}_linux_armhfv6.zip
	rm consul_${CONSUL_VERSION}_linux_armhfv6.zip
	sudo mv consul /usr/bin

	# Install Vault
	# NOTE: Vault doesn't have an armhfv6 binary

	# Install Nomad
	# NOTE: Nomad doesn't have an armhfv6 binary

	# Install Terraform
	# NOTE: Terraform doesn't have an armhfv6 binary

	# Install Packer
	# NOTE: Packer doesn't have an armhfv6 binary

	# Install Boundary
	# NOTE: Boundary doesn't have an armhfv6 binary

	# Install Waypoint
	# NOTE: Waypoint doesn't have an armhfv6 binary
fi

if [ "$architecture" == "aarch64" ]; then
	# Install Consul
	wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_arm64.zip
	unzip -o consul_${CONSUL_VERSION}_linux_arm64.zip
	rm consul_${CONSUL_VERSION}_linux_arm64.zip
	sudo mv consul /usr/bin

	# Install Vault
	# wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_arm64.zip
	# unzip -o vault_${VAULT_VERSION}_linux_arm64.zip
	# rm vault_${VAULT_VERSION}_linux_arm64.zip
	# sudo mv vault /usr/bin

	# Install Nomad
	# wget https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_arm64.zip
	# unzip -o nomad_${NOMAD_VERSION}_linux_arm64.zip
	# rm nomad_${NOMAD_VERSION}_linux_arm64.zip
	# sudo mv nomad /usr/bin

	# Install Terraform
	# https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip
	# unzip -o terraform_${TERRAFORM_VERSION}_linux_arm64.zip
	# rm terraform_${TERRAFORM_VERSION}_linux_arm64.zip
	# sudo mv terraform /usr/bin

	# Install Packer
	# https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_arm64.zip
	# unzip -o packer_${PACKER_VERSION}_linux_arm64.zip
	# rm packer_${PACKER_VERSION}_linux_arm64.zip
	# sudo mv packer /usr/bin

	# Install Boundary
	# https://releases.hashicorp.com/boundary/${BOUNDARY_VERSION}/boundary_${BOUNDARY_VERSION}_linux_arm64.zip
	# unzip -o boundary_${BOUNDARY_VERSION}_linux_arm64.zip
	# rm boundary_${BOUNDARY_VERSION}_linux_arm64.zip
	# sudo mv boundary /usr/bin

	# Install Waypoint
	# NOTE: Waypoint doesn't have an arm64 binary
fi


# TODO: Setup and run all the services we just installed.
