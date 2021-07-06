#!/bin/bash

# Get the PEM from RPI1, save it locally, then distribute it.
scp rpi1:/home/ubuntu/consul-agent-ca.pem .
scp consul-agent-ca.pem rpi2:/home/ubuntu/consul-agent-ca.pem
scp consul-agent-ca.pem rpi3:/home/ubuntu/consul-agent-ca.pem
scp consul-agent-ca.pem rpi4:/home/ubuntu/consul-agent-ca.pem
rm consul-agent-ca.pem