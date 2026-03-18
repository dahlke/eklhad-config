# Raspberry Pi Terraform

Bootstrap Raspberry Pi nodes over SSH using Terraform and repo scripts.

## Prereqs

- Terraform
- SSH access to each Pi
- Bootstrap scripts in `scripts/bash/rasppi`

## Setup

```bash
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
terraform init
terraform fmt
terraform apply
```

## Variables

- `rpi_addresses`: map of node names to IPs
- `rpi_leader_address`: leader node IP
- `rpi_follower_addresses`: map of follower node names to IPs
- `rpi_username`: SSH username (e.g. `ubuntu`)
- `rpi_ssh_priv_key_path`: path to SSH private key

Note: The scripts under `scripts/bash/rasppi` are currently minimal placeholders.
Add the real provisioning steps there as you evolve the setup.
