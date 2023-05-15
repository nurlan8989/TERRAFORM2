
locals {
  vps_ip = element(digitalocean_droplet.vm.*.ipv4_address,0)
}



data "aws_route53_zone" "arman_rebrain" {
  name         = "devops.rebrain.srwx.net"
  
 
 }





resource "aws_route53_record" "arman_devops_rebrain_srwx_net2" {
  #count = length(var.devs) 
   count = "${length( keys(var.devs))}"
  zone_id = data.aws_route53_zone.arman_rebrain.zone_id 
  #name    = "${var.devs[count.index].your_login}-${var.devs[count.index].prefix}.devops.rebrain.srwx.net"
  name    = "${element(values(var.devs), count.index)}.${data.aws_route53_zone.arman_rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = [digitalocean_droplet.vm[count.index].ipv4_address]
 # depends_on = [digitalocean_droplet.vm]

  
}

  