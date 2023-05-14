output "droplet_ip_address" {
  value = digitalocean_droplet.vm[0].ipv4_address
}



output "server_ssh_brain_id" {
  value =  data.digitalocean_ssh_key.example.id
}


output "aws_dns_zone_id" {
value = data.aws_route53_zone.arman_rebrain.zone_id 
}


output "droplet_vm_name" {
  value = digitalocean_droplet.vm[0].name
}

