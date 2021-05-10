# Raspberry Pi Home Cluster Setup

## Disk Imaging

From [Raspberry Pi Software](https://www.raspberrypi.org/software/), use the Raspberry Pi Imager to install `Ubuntu Server 20.04.LTS x64` on each SD card that will be used in the cluster.

## WiFi Configuration

After creating and verifying each image, set up the WiFi for each Pi Board by modifying the `network-config` file as described in this [tutorial](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#3-wifi-or-ethernet).

## Get Pi Board IP Addresses

Once the image is successfully created, and the WiFi is configured, start up each Pi board, and log into the box manually, using an HDMI monitor and a USB keyboard plugged into the board. If it's the first time you are logging into the Pi Board, The initial log in will be `ubuntu:ubuntu`, and you will be forced to change it (Ex: `ubuntu:foobar123`).

After you have logged into the board, run `ip addr` and check the `wlan0` IP address in the output. You'll want to copy this address to whichever machine you intend to use as a client for each Pi Board. It's a good idea to write this info to `~/.ssh/config` for easy access in the future. Example format below, where the IP address is `10.0.1.58`.

```txt
Host rpi1
     HostName 10.0.1.58
     User ubuntu
     IdentityFile ~/.ssh/rpi/rpi.pem
```

_NOTE: If you power cycle the Pi Boards before you set up static IP addresses for each of them (below), then the IP address may change, and you may need to update the SSH config._

## Configure SSH Keys

Generate an SSH key on the intended client machine. Example:

```bash
mkdir -p ~/.ssh/rpi/
cd ~/.ssh/rpi/
ssh-keygen

# name it rpi, no passphrase
```

Once the keys are generated, `cat` the `rpi.pub` key.

```bash
# On the client
cat ~/.ssh/rpi/rpi.pub # copy the output
```

Add it to `~/.ssh/authorized_keys` on each Pi board.

```bash
# On the Pi Board
vim ~/.ssh/authorized_keys # then paste the pub key
```

Update the clients `~/.ssh/config` file to use the private `pem` key after you set up the public key. Do this for all Pi Boards.

```txt
Host rpi1
     HostName 10.0.1.58
     User ubuntu
     IdentityFile ~/.ssh/rpi/rpi.pem
```

Then make sure that the new SSH setup works, by `exit`ing the connection to the Pi Board, and re-establishing the connection without providing a password.

```bash
ssh rpi1 # should have no password prompt
```

## Change Pi Hostname per Board

On each board, change the hostname to represent it's number in the rack to make it easier to find later.

```bash
sudo hostnamectl set-hostname rpi1
...
```

## (Optional) HashiCorp Stuff

With `csshx` installed, and your `~/.ssh/config` properly updated, run:

```bash
csshx rpi1 rpi2 rpi3 rpi4
```

Once you are logged in to all of the boxes via `csshx`, install the relevant HashiCorp tools I want to use.

```bash
sudo apt-get update
sudo apt-get install -y consul vault nomad waypoint boundary packer terraform
```

### Install Consul, Vault, Nomad, Waypoint, Boundary, Terraform

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update

sudo apt-get install vault
sudo apt-get install consul
sudo apt-get install nomad
sudo apt-get install terraform
sudo apt-get install waypoint
```

# Helpful

## Find Raspberry Pi IP Addresses on Home Network

["All raspberry devices MAC addresses started with `B8:27:EB` (for RPi4 B they start with `dc:a6:32`, replace where appropriate)."](https://raspberrypi.stackexchange.com/questions/13936/find-raspberry-pi-address-on-local-network)

```bash
arp -na | grep -i b8:27:eb
```

### TODO

- [Helpful](https://patrick.veverka.net/2020/02/26/hashicorp-home-cluster/)