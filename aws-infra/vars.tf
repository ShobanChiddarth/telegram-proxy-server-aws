variable "region" {
  type = string
  description = "Thailand; closest to India that is not affected by WW3 and also not in China"
  default = "ap-southeast-7"
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

    proxy_server = <<-EOF
        apt install -y awscli
        mkdir -p /data
        PROXY_SECRET=$(aws ssm get-parameter --region ${var.region} --name "${aws_ssm_parameter.proxy_secret.name}" --query "Parameter.Value" --output text)
        echo "$PROXY_SECRET" > /data/secret
        echo "-- -S $PROXY_SECRET" > /data/secret_cmd
        docker pull telegrammessenger/proxy:latest
        docker run -d -p 0.0.0.0:443:443 --name=mtproto-proxy --restart=always -v /data:/data telegrammessenger/proxy:latest
EOF
  }
}

variable "my_public_ip" {
    type = string
    description = "my public ip"
    default = "0.0.0.0/0"
}
