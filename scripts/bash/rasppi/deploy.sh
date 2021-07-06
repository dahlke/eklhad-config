#!/bin/bash

# scp the install files

# run the installs

# get the gossip encryption key down

# scp the gossip encryption key to all the other nodes

# Get the PEM from RPI1, save it locally, then distribute it.
scp rpi1:/home/ubuntu/consul-agent-ca.pem .
scp consul-agent-ca.pem rpi2:/home/ubuntu/consul-agent-ca.pem
scp consul-agent-ca.pem rpi3:/home/ubuntu/consul-agent-ca.pem
scp consul-agent-ca.pem rpi4:/home/ubuntu/consul-agent-ca.pem
rm consul-agent-ca.pem

# get all the other certs and distribute those

# start all the services in the right order