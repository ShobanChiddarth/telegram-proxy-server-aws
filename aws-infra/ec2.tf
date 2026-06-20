locals {
  base_init = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get upgrade -y
EOF

  proxyserver_init = <<-EOF
    mkdir /data
    curl https://get.docker.com | bash
    adduser ubuntu docker
    docker pull telegrammessenger/proxy:latest
    docker run -d -p 0.0.0.0:443:443 --name=mtproto-proxy --restart=always -v /data:/data telegrammessenger/proxy:latest
    docker pull shobanchiddarth/tproxy-server-expose-details:1.0.0
    docker run -d -p 0.0.0.0:8000:8000 --name=expose-details --restart=always -v /data:/data shobanchiddarth/tproxy-server-expose-details:1.0.0
EOF

}

resource "aws_instance" "ProxyServer" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.MainSubnet.id
  associate_public_ip_address = true
  user_data = join("\n", [local.base_init, local.proxyserver_init])
  vpc_security_group_ids = [ aws_security_group.allow_ssh_https_ping.id ]
  key_name = aws_key_pair.proxy_server_key_pair.key_name

  tags = {
    Name = "ProxyServer"
  }
}
