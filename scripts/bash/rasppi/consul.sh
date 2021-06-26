#!/bin/bash

# TODO:
# - remove all the echos to the file system when it's ready to go, format the machines so they are fresh
# - more comments from the production deploy docs


#############################################################################################
# 										CONSUL 												#
# https://learn.hashicorp.com/tutorials/consul/deployment-guide?in=consul/production-deploy #
#############################################################################################

DC_NAME="dc-1"


##################
# INSTALL CONSUL #
##################

# The consul command features opt-in autocompletion for flags, subcommands, and arguments (where supported).
consul -autocomplete-install

# Enable autocompletion.
complete -C /usr/bin/consul consul

# Create a unique, non-privileged system user to run Consul and create its data directory.
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul


####################################
# PREPARE THE SECURITY CREDENTIALS #
####################################

# Generate the gossip encryption key (and store it for later usage)
CONSUL_GOSSIP_KEY=$(consul keygen)
echo $CONSUL_GOSSIP_KEY
echo "export CONSUL_GOSSIP_KEY=$CONSUL_GOSSIP_KEY" >> ~/.bashrc


# Generate TLS certificates for RPC encryption
# Create the Certificate Authority
consul tls ca create

# TODO: store the cert in a variable, place it on the disk as well.
consul tls cert create -server -dc rpi_dc1

# The CA cert must be distributed to all hosts in the system.
# TODO: only do this on the primary
# scp consul-agent-ca.pem <dc-name>-<server/client>-consul-<cert-number>.pem <dc-name>-<server/client>-consul-<cert-number>-key.pem <USER>@<PUBLIC_IP>:/etc/consul.d/

###########################
# CONFIGURE CONSUL AGENTS #
###########################

sudo mkdir --parents /etc/consul.d
sudo touch /etc/consul.d/consul.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul.hcl

# TODO: update the values in the below config to have the right IPs and keys
# TODO: telemetry
# TODO: audit
cat <<-EOF > /etc/consul.d/consul.hcl
datacenter = "dc1"
data_dir = "/opt/consul"
encrypt = "qDOPBEr+/oUVeOFQOnVypxwDaHzLrD+lvjo5vCEBbZ0="
ca_file = "/etc/consul.d/consul-agent-ca.pem"
cert_file = "/etc/consul.d/dc1-server-consul-0.pem"
key_file = "/etc/consul.d/dc1-server-consul-0-key.pem"
verify_incoming = true
verify_outgoing = true
verify_server_hostname = true
retry_join = ["172.16.0.11"]

acl = {
  enabled = true
  default_policy = "allow"
  enable_token_persistence = true
}

performance {
  raft_multiplier = 1
}
EOF


############################
# CONFIGURE CONSUL SERVERS #
############################

sudo touch /etc/consul.d/server.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/server.hcl

# TODO: update the values in the below config to have the right IPs and keys
cat <<-EOF > /etc/consul.d/server.hcl
server = true
bootstrap_expect = 3
client_addr = "0.0.0.0"
ui = true
EOF


################################
# CONFIGURE THE CONSUL PROCESS #
################################

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
sudo systemctl enable consul
sudo systemctl start consul
sudo systemctl status consul


######################################
# SETUP CONSUL ENVIRONMENT VARIABLES #
######################################

# TODO: add these to the bashrc
export CONSUL_CACERT=/etc/consul.d/consul-agent-ca.pem
export CONSUL_CLIENT_CERT=/etc/consul.d/<dc-name>-<server/ client>-consul-<cert-number>.pem
export CONSUL_CLIENT_KEY=/etc/consul.d/<dc-name>-<server/   client>-consul-<cert-number>-key.pem


############################
# BOOTSTRAP THE ACL SYSTEM #
############################

# Working from one agent generate the Consul bootstrap token, which has unrestricted privileges.  This will return the Consul bootstrap token.
# You will need the SecretID for all subsequent Consul API requests (including CLI and UI). Ensure that you save the SecretID.
consul acl bootstrap

# Set CONSUL_MGMT_TOKEN env variable.
export CONSUL_HTTP_TOKEN="<Token SecretID from previous step>"
export CONSUL_MGMT_TOKEN="<Token SecretID from previous step>"

mkdir -p /etc/consul.d/policies/
sudo touch /etc/consul.d/policies/node-policy.hcl

# Create a node policy file (node-policy.hcl) with write access for nodes related actions and read access for service related actions.
cat <<-EOF > /etc/consul.d/policies/node-policy.hcl
agent_prefix "" {
  policy = "write"
}
node_prefix "" {
  policy = "write"
}
service_prefix "" {
  policy = "read"
}
session_prefix "" {
  policy = "read"
}
EOF

# Generate the Consul node ACL policy with the newly created policy file.
consul acl policy create \
  -token=${CONSUL_MGMT_TOKEN} \
  -name node-policy \
  -rules @node-policy.hcl

# Create the node token with the newly created policy.
consul acl token create \
  -token=${CONSUL_MGMT_TOKEN} \
  -description "node token" \
  -policy-name node-policy

# On all Consul Servers add the node token.
consul acl set-agent-token \
  -token="<Management Token SecretID>" \
  agent "<Node Token SecretID>"


#################################
# ... APPLY ENTERPRISE LICENSE? #
#################################

exit 0
