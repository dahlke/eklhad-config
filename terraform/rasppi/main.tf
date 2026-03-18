# https://github.com/clayshek/terraform-raspberrypi-bootstrap

resource "null_resource" "rpi_setup_all" {
  for_each = var.rpi_addresses

  connection {
    type = "ssh"
    # TODO: figure out if I can use the hostnames from ssh/config
    user        = var.rpi_username
    host        = each.value
    private_key = file("${var.rpi_ssh_priv_key_path}")
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/scripts/",
    ]
  }

  provisioner "file" {
    source      = "../../scripts/bash/rasppi/install.sh"
    destination = "/home/ubuntu/scripts/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 scripts/*.sh",
      "./scripts/install.sh",
    ]
  }
}


/*
data "external" "example" {
  program = ["python", "${path.module}/example-data-source.py"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    id = "abc123"
  }
}
*/

# TODO: use depends on
# https://stackoverflow.com/questions/56474709/how-to-store-terraform-provisioner-local-exec-output-in-local-variable-and-use
# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source