#!/bin/bash

# NOTE: Binary installation in install.sh

# TODO: get this form a file or get rid of these altogether maybe?
PRIMARY_HOST="rpi1"
SERVER_HOSTS=("rpi1" "rpi2" "rpi3")
CLIENT_HOSTS=("rpi4")
HOSTS=("rpi1" "rpi2" "rpi3" "rpi4")

# Parse the CLI args
while getopts t:d: flag
do
    case "${flag}" in
        t) agent_type=${OPTARG};;
        d) dc_name=${OPTARG};;
    esac
done

# TODO: validate the agent types and make sure args aren't empty
echo "Type: $agent_type";
echo "DC Name: $dc_name";

# ALL NODES
## Install auto-completion
# consul -autocomplete-install
# complete -C /usr/bin/consul consul

## Create a unique, non-privileged system user to run Consul and create its data directory.
# sudo useradd --system --home /etc/consul.d --shell /bin/false consul
# sudo mkdir --parents /opt/consul
# sudo chown --recursive consul:consul /opt/consul

if [[ $agent_type == "primary" ]]; then
    echo "Generating gossip encryption key on primary, and storing in ~/.bashrc..."
    consul_gossip_key=$(consul keygen)
    echo "Gossip Key:" $consul_gossip_key
    echo "export CONSUL_GOSSIP_KEY=\"$consul_gossip_key\"" >> ~/.bashrc

    # Create the Certificate Authority
    echo "Creating the certificate authority..."
    consul tls ca create

    for server_host_name in "${SERVER_HOSTS[@]}"
    do
        echo "Creating a cert for server: $server_host_name ..."
    done

    for client_host_name in "${CLIENT_HOSTS[@]}"
    do
        echo "Creating a cert for client: $client_host_name ..."
    done
fi

if [[ "$agent_type" == "server" || "$agent_type" == "primary" ]]; then
  echo "It's a $agent_type, do all the server install stuff."
fi

if [[ $agent_type == "client" ]]; then
  echo "It's a $agent_type, do only the client install stuff."
fi

exit 0
