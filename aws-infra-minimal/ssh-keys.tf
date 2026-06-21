resource "tls_private_key" "proxy_server_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "proxy_server_key_pair" {
  key_name = "proxy_server_key_pair"
  public_key = tls_private_key.proxy_server_key.public_key_openssh
}

resource "local_file" "proxy_server_priv_key_local_file" {
  filename = "${path.module}/.ssh/${aws_key_pair.proxy_server_key_pair.key_name}.pem"
  content = tls_private_key.proxy_server_key.private_key_openssh
  file_permission = 0600
}
