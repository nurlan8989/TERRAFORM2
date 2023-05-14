resource "digitalocean_ssh_key" "key1" {
  name       = "key1"
  public_key = file(var.public_key1)
}



data "digitalocean_ssh_key" "example" {
  name = "REBRAIN.SSH.PUB.KEY"
}




resource "random_password" "server_password" {
  length  = 16
  special = true
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






 provisioner "remote-exec" {
    inline = [
      "echo 'New password: ${random_password.server_password.result}'"
    ]
  }

  
connection {
    type = "ssh"
    user = "root"
    private_key = file(var.private_key_path)
    host = self.ipv4_address
  }

tags =  [
   "module:devops" , "email:your_email"
  
]


}
