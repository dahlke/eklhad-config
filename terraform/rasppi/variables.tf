variable "rpi_addresses" {
  type = map(any)
}

variable "rpi_leader_address" {
  type = string
}

variable "rpi_follower_addresses" {
  type = map(any)
}

variable "rpi_username" {
  type = string
}

variable "rpi_ssh_priv_key_path" {
  type = string
}
