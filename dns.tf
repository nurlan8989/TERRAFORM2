
locals {
  vps_ip = digitalocean_droplet.vm.ipv4_address
}



data "aws_route53_zone" "arman_rebrain" {
  name         = "devops.rebrain.srwx.net"
  
 
 }


resource "aws_route53_record" "arman_devops_rebrain_srwx_net2" {
  zone_id = data.aws_route53_zone.arman_rebrain.zone_id 
  name    = "${var.login}-${var.serial_number}.${data.aws_route53_zone.arman_rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = ["${local.vps_ip}"]
  depends_on = [digitalocean_droplet.vm]

  
}

