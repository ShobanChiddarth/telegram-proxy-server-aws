output "Proxy_Server_Public_IP" {
  value = aws_instance.single.public_ip
}
