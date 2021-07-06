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
	for node in nodes:
		hostname = node["hostname"]
		conn = Connection(hostname)
		# TODO: don't hardcode the target
		conn.run("mkdir -p /home/ubuntu/hashistack")
		conn.put("../../bash/rasppi/", "/home/ubuntu/hashistack")
		# conn.put("../../bash/rasppi/install.sh", "/home/ubuntu")
		# from fabric import Connection
		# c = Connection('web1')
		# c.put('myfiles.tgz', '/opt/mydata')
		# c.run('tar -C /opt/mydata -xzvf /opt/mydata/myfiles.tgz')

		result = conn.run('ls /tmp/')
		print("result", result)
		break

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
