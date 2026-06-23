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
