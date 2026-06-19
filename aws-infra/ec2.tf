locals {
  base_init = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get upgrade -y
EOF

}

resource "aws_instance" "single" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.singleSubnet.id
  associate_public_ip_address = true
  user_data = local.base_init
  vpc_security_group_ids = [ aws_security_group.allow_ssh_https_ping.id ]
  key_name = aws_key_pair.singleEC2keypair.key_name

  tags = {
    Name = "single"
  }
}
