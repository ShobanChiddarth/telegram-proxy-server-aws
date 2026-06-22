resource "aws_vpc" "TProxyVPC" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "TProxyVPC"
  }

}

resource "aws_internet_gateway" "TProxyIGW" {
  vpc_id = aws_vpc.TProxyVPC.id

  tags = {
    "Name" = "TProxyIGW"
  }

}
