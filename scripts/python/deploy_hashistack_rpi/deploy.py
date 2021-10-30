#!/bin/python3
import json
from fabric import Connection

# TODO: python script that shuffles all the files around and handles edge cases better than bash
# TODO: use contexts if necessary

def get_nodes():
	nodes = {}

	with open("nodes.json", "r") as infile:
		nodes = json.loads(infile.read())["nodes"]

	return nodes

def install_hashistack(nodes):
	# TODO: make this concurrent in threads
	for node in nodes:
		hostname = node["hostname"]
		conn = Connection(hostname)

		# Create all the script directories that will be needed
		conn.run('mkdir -p /home/ubuntu/scripts/consul')
		conn.run('mkdir -p /home/ubuntu/scripts/vault')
		conn.run('mkdir -p /home/ubuntu/scripts/nomad')
		conn.run('mkdir -p /home/ubuntu/scripts/terraform')
		conn.run('mkdir -p /home/ubuntu/scripts/packer')
		conn.run('mkdir -p /home/ubuntu/scripts/waypoint')
		conn.run('mkdir -p /home/ubuntu/scripts/boundary')

		conn.put("../../bash/rasppi/install.sh", "/home/ubuntu/install.sh")
		conn.put("../../bash/rasppi/consul/setup_basics.sh", "/home/ubuntu/scripts/consul/setup_basics.sh")
		# conn.put("../../bash/rasppi/consul/setup_primary.sh", "/home/ubuntu/scripts/consul/setup_primary.sh")

		# Set the permissions on all the install scripts
		conn.run("chmod 755 *.sh")
		conn.run("chmod 755 scripts/**/*.sh")

		# Then install all the binaries
		install_result = conn.run("./install.sh")
		print(install_result)

		basics_result = conn.run("./scripts/consul/setup_basics.sh")
		print(basics_result)

		# primary_result = conn.run("./scripts/consul/setup_primary.sh")
		# print(primary_result)

		# TODO: zip and then unpack them
		# c.put('myfiles.tgz', '/opt/mydata')
		# c.run('tar -C /opt/mydata -xzvf /opt/mydata/myfiles.tgz')

def setup_primary():
	print("primary")
	pass

def setup_servers():
	print("servers")
	pass

def setup_agents():
	print("agent")
	pass

if __name__ == "__main__":
	nodes = get_nodes()
	install_hashistack(nodes)
	setup_primary()
	setup_servers()
	setup_agents()
