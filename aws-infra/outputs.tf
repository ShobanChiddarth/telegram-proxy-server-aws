output "Proxy_Server_Public_EIP" {
  value = aws_eip.ProxyServerEIP.public_ip
}
