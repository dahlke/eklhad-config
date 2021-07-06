# TODO:
# - remove all the echos to the file system when it's ready to go, format the machines so they are fresh
# - more comments from the production deploy docs

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