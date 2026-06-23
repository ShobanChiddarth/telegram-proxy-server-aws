# AWS Systems Manager Parameter Store
# Store 2 parameters
# proxy-secret:$(head -c 16 /dev/urandom | xxd -ps)
# admin-password:admin@123 (please change later)

resource "aws_ssm_parameter" "proxy_secret" {
  name = "/tproxy/proxy-secret"
  type = "String"
  value = var.proxy_secret
}

resource "aws_ssm_parameter" "admin_password" { # will be used later
  name = "/tproxy/admin-password"
  type = "String"
  value = var.admin_password
}
