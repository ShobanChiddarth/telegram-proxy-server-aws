resource "aws_subnet" "PublicSubnet1" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[0]
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[1]
}
