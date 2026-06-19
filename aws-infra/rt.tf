resource "aws_route_table" "to_igw" {
  vpc_id = aws_vpc.singleEC2VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.singleEC2igw.id
  }

  tags = {
    "Name" = "to_igw"
  }
}
