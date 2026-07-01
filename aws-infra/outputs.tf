output "nlb_dns" {
    value = aws_lb.proxy_nlb.dns_name
}

output "port" {
    value = aws_lb_listener.proxy_nlb_listener.port
}

output "proxy_secret" {
    value = nonsensitive(aws_ssm_parameter.proxy_secret.value)
}

output "bastion_public_ip" {
    value = aws_eip.bastion_eip.public_ip
}
