#!/bin/bash

echo "Preparing the security credentials..."
echo "Generating gossip encryption key on primary, and storing in ~/.bashrc..."
consul_gossip_key=$(consul keygen)
# TODO: remove this programmatically
touch gossip_key.txt
echo $consul_gossip_key > gossip_key.txt
echo "export CONSUL_GOSSIP_KEY=\"$consul_gossip_key\"" >> ~/.bashrc

echo "Creating the certificate authority..."
consul tls ca create

server_index=1
for server_host_name in "${SERVER_HOSTS[@]}"
do
	echo "Creating a cert for server: $server_host_name ..."
	consul tls cert create -server -dc $dc_name
	echo "$dc_name-server-consul-$server_index"
	# TODO: scp them?
	server_index=$((server_index+1))
done

client_index=1
for client_host_name in "${CLIENT_HOSTS[@]}"
do
	echo "Creating a cert for client: $client_host_name ..."
	consul tls cert create -client -dc $dc_name
	echo "$dc_name-client-consul-$client_index"
	# TODO: scp consul-agent-ca.pem $dc_name-client-consul-$client_index.pem $dc_name-client-consul-<cert-number>-key.pem <USER>@<PUBLIC_IP>:/etc/consul.d/
	client_index=$((client_index+1))
done

exit 0
