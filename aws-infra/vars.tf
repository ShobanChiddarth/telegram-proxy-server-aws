variable "region" {
  type = string
  description = "Singapore; closest to India that is not affected by WW3 and also not in China and not in Thailand (Thailand not working)"
  default = "ap-southeast-1"
}

data "aws_availability_zones" "AZs" {
  state = "available"
}

variable "admin_password" {
  type = string
  sensitive = true
}

variable "proxy_secret" {
  type = string
  sensitive = false
}

variable "user_data" {
  type = map(string)
  description = "EC2 User Data base"

  default = {
    base = <<-EOF
        #!/bin/bash
        apt-get update
        apt-get upgrade -y
EOF

    docker_install = <<-EOF
        curl https://get.docker.com | bash
        adduser ubuntu docker
EOF
  }
}

variable "my_public_ip" {
    type = string
    description = "my public ip"
    default = "0.0.0.0/0"
}
