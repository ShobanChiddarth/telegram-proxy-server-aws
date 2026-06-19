resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "singleEC2keypair" {
  key_name = "singleEC2keypair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "priv_key" {
  filename = "${path.module}/.ssh/${aws_key_pair.singleEC2keypair.key_name}.pem"
  content = tls_private_key.ssh_key.private_key_openssh
  file_permission = 0600
}
