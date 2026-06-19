resource "aws_subnet" "MainSubnet" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.0.0/24"

  tags = {
    "Name" = "singleSubnet"
  }
}

resource "aws_route_table_association" "one" {
    subnet_id = aws_subnet.MainSubnet.id
    route_table_id = aws_route_table.to_igw.id
}
