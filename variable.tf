variable "do_token" {}

variable "public_key1" {
  
}


variable "login" {
  
}


variable "access_key" {
  
}

variable "secret_key" {
  
}

variable "region" {
  
}



variable "serial_number" {
  }


variable "private_key_path" {
  
}

variable "devs" {
  #type = list(map(string))
  default = {
      1 = "lb-rhel"
      2 = "app1-rhel"
     # 3 = "app2-rhel2"
    }
}


