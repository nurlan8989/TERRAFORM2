output "droplet_ip_address" {
  value = ["${digitalocean_droplet.vm[*].ipv4_address}"]
}



output "server_ssh_brain_id" {
  value =  data.digitalocean_ssh_key.example.id
}


output "aws_dns_zone_id" {
value = data.aws_route53_zone.arman_rebrain.zone_id 
}


output "droplet_vm_name" {
  value = digitalocean_droplet.vm[*].name
}


#output "server_password" {
 # value = random_password.server_password.result
  #sensitive = true
#}

output "hostnames" {
    value = ["${aws_route53_record.arman_devops_rebrain_srwx_net2.*.fqdn}"]

}


output "root_password" {
  value = nonsensitive(jsondecode(jsonencode(["${random_password.server_password[*].result}"])))
}

output "template_file" {
 value = data.template_file.init[*].rendered
}