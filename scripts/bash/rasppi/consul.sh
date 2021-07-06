#!/bin/bash

# NOTE: Binary installation in install.sh

# TODO: get this form a file or get rid of these altogether maybe?
# TODO: upload the ssh key to each host so they can reach each other
PRIMARY_HOST="rpi1"
SERVER_HOSTS=("rpi1" "rpi2" "rpi3")
CLIENT_HOSTS=("rpi4")
HOSTS=("rpi1" "rpi2" "rpi3" "rpi4")

# Parse the CLI args
# TODO: validate the agent types and make sure args aren't empty
while getopts t:n: flag
do
    case "${flag}" in
        t) agent_type=${OPTARG};;
        n) dc_name=${OPTARG};;
    esac
done

echo "Installing Consul auto-completion..."
# consul -autocomplete-install
# complete -C /usr/bin/consul consul

echo "Creating a unique, non-privileged system user to run Consul and creating a data directory..."
# sudo useradd --system --home /etc/consul.d --shell /bin/false consul
# sudo mkdir --parents /opt/consul
# sudo chown --recursive consul:consul /opt/consul

# Commands that only need to be run on the primary
if [[ $agent_type == "primary" ]]; then
    echo "Preparing the security credentials..."
    echo "Generating gossip encryption key on primary, and storing in ~/.bashrc..."
    consul_gossip_key=$(consul keygen)
    echo "Gossip Key:" $consul_gossip_key
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
fi

if [[ "$agent_type" == "server" || "$agent_type" == "primary" ]]; then
    echo "Running server specific install steps..."

    sudo touch /etc/consul.d/server.hcl
    sudo chown --recursive consul:consul /etc/consul.d
    sudo chmod 640 /etc/consul.d/server.hcl
    # TODO: update the bootstrap expect value below
    cat <<-EOF > /etc/consul.d/server.hcl
server = true
bootstrap_expect = 3
client_addr = "0.0.0.0"
ui = true
EOF
fi

# Commands that need to be run on all members of the cluster (servers and clients)
echo "Running client specific install steps..."
sudo mkdir --parents /etc/consul.d
sudo touch /etc/consul.d/consul.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul.hcl

# TODO: update the values in the below config to have the right IPs and keys
# TODO: encrypt, ca_file / cert_file / key_file / retry_join
cat <<-EOF > /etc/consul.d/consul.hcl
datacenter = "dc1"
data_dir = "/opt/consul"
encrypt = "<TODO>"
ca_file = "/etc/consul.d/consul-agent-ca.pem"
cert_file = "/etc/consul.d/dc1-server-consul-<TODO>.pem"
key_file = "/etc/consul.d/dc1-server-consul-<TODO>-key.pem"
verify_incoming = true
verify_outgoing = true
verify_server_hostname = true
retry_join = ["172.16.0.11", "TODO"]

acl = {
enabled = true
default_policy = "allow"
enable_token_persistence = true
}

performance {
raft_multiplier = 1
}
EOF
fi

# Configure the Consul process
sudo touch /usr/lib/systemd/system/consul.service

cat <<-EOF > /usr/lib/systemd/system/consul.service
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
User=consul
Group=consul
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

consul validate /etc/consul.d/consul.hcl

# TODO: do this properly as well.
# export CONSUL_CACERT=/etc/consul.d/consul-agent-ca.pem
# export CONSUL_CLIENT_CERT=/etc/consul.d/<dc-name>-<server/ client>-consul-<cert-number>.pem
# export CONSUL_CLIENT_KEY=/etc/consul.d/<dc-name>-<server/   client>-consul-<cert-number>-key.pem

# TODO: don't start everything yet, unless it's happening in a specific order.
# sudo systemctl enable consul
# sudo systemctl start consul
# sudo systemctl status consul

# TODO: add a dry run flag
echo "REMOVE THESE"
echo "removing generated PEM files and directories..."
# TODO: clean up systemd files
rm *.pem
rm -rf /opt/consul
rm -rf /etc/consul

exit 0
