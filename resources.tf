resource "digitalocean_ssh_key" "key1" {
  name       = "key1"
  public_key = file(var.public_key1)
}



data "digitalocean_ssh_key" "example" {
  name = "REBRAIN.SSH.PUB.KEY"
}

resource "digitalocean_droplet" "vm" {
  image    = "ubuntu-20-04-x64"
  name     = "test"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  count = var.vps_count
    ssh_keys = [
    digitalocean_ssh_key.key1.id,
    data.digitalocean_ssh_key.example.id
  ]
tags = [
    "devops" , "arman_anuarbekov_at_gmail_com"
  ]
}
