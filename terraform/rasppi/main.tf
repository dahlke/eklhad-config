# https://github.com/clayshek/terraform-raspberrypi-bootstrap

# TODO: figure out if I can use the hostnames from ssh/config

resource "null_resource" "raspberry_pi_bootstrap" {
  for_each = var.rpi_addresses

  connection {
    type = "ssh"
    user = var.rpi_username
    host = each.value
    private_key = file("${var.rpi_ssh_priv_key_path}")
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/scripts/",
      "mkdir -p /home/ubuntu/scripts/consul"
    ]
  }

  provisioner "file" {
    source      = "../../scripts/bash/rasppi/install.sh"
    destination = "/home/ubuntu/scripts/install.sh"
  }

  provisioner "file" {
    source      = "../../scripts/bash/rasppi/consul/setup_basics.sh"
    destination = "/home/ubuntu/scripts/consul/setup_basics.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 scripts/*.sh",
      "chmod 755 scripts/**/*.sh",
      "./scripts/install.sh"
    ]
  }
}