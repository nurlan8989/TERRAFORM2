
locals {
  vps_ip = var.vps_ip
}


data "aws_route53_zone" "arman_rebrain" {
  name         = "devops.rebrain.srwx.net"
 
 }



resource "aws_route53_record" "arman_devops_rebrain_srwx_net2" {
  zone_id = data.aws_route53_zone.arman_rebrain.zone_id 
  name    = "${var.login}-devops-rebrain-srwx-net"
  type    = "A"
  ttl     = "300"
  records =  [ local.vps_ip ]

}