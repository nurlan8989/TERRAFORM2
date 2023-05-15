resource "digitalocean_ssh_key" "key1" {
  name       = "key1"
  public_key = file(var.public_key1)
}



data "digitalocean_ssh_key" "example" {
  name = "REBRAIN.SSH.PUB.KEY"
}




resource "random_password" "server_password" {
  count = "${length( keys(var.devs))}"
  length  = 16
  upper = true
  lower = true
  number = true
  special = false
}


resource "digitalocean_droplet" "vm" {
  image    = "ubuntu-20-04-x64"
  #name     = "${var.devs[count.index].prefix}-${var.devs[count.index].your_login}"
  name = "${element(values(var.devs), count.index)}"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
 # count = length(var.devs) 
  count = "${length( keys(var.devs))}"
  ssh_keys = [
    digitalocean_ssh_key.key1.id,
    data.digitalocean_ssh_key.example.id
  ]
 provisioner "remote-exec" {
    inline = [
      "echo \"root:${random_password.server_password[count.index].result}\" | chpasswd" 
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

data "template_file" "init" {
  template = file("init.tpl")
  count    = "${length( keys(var.devs))}"
  vars = {
    "vm_num"  = "${element(keys(var.devs), count.index)}"
    "dns_name" = "${element(values(var.devs), count.index)}.${data.aws_route53_zone.arman_rebrain.name}"
    "vm_ip"   = "${element(digitalocean_droplet.vm.*.ipv4_address, count.index)}"
    "root_pass" = "${element(random_password.server_password.*.result, count.index)}"
}
}

resource "local_file" "local" {
  content  = "${join("",data.template_file.init[*].rendered )}"
  filename = "ter_08"
}



