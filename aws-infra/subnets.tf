resource "aws_subnet" "PublicSubnet1" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[0]
}

resource "aws_route_table_association" "publicSubnet1RTassoc" {
  subnet_id = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.to_igw.id
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[1]
}

resource "aws_route_table_association" "publicSubnet2RTassoc" {
  subnet_id = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.to_igw.id
}
