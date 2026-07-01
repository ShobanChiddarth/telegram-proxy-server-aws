resource "aws_subnet" "ManagementSubnet" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[0]

  tags = {
      Name = "ManagementSubnet"
  }
}

resource "aws_route_table_association" "managementSubnetRTassoc" {
  subnet_id = aws_subnet.ManagementSubnet.id
  route_table_id = aws_route_table.to_igw.id
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[0]

  tags = {
      Name = "PublicSubnet1"
  }
}

resource "aws_route_table_association" "publicSubnet1RTassoc" {
  subnet_id = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.to_igw.id
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.TProxyVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.AZs.names[1]

  tags = {
      Name = "PublicSubnet2"
  }
}

resource "aws_route_table_association" "publicSubnet2RTassoc" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.to_igw.id
}

resource "aws_subnet" "PrivateSubnet1" {
    vpc_id = aws_vpc.TProxyVPC.id
    cidr_block = "10.0.3.0/24"
    availability_zone = data.aws_availability_zones.AZs.names[0]

    tags = {
        "Name" = "PrivateSubnet1"
    }
}

resource "aws_route_table_association" "priv1RTassoc" {
    subnet_id = aws_subnet.PrivateSubnet1.id
    route_table_id = aws_route_table.to_nat_instance.id
}


resource "aws_subnet" "PrivateSubnet2" {
    vpc_id = aws_vpc.TProxyVPC.id
    cidr_block = "10.0.4.0/24"
    availability_zone = data.aws_availability_zones.AZs.names[1]

    tags = {
        Name = "PrivateSubnet2"
    }
}

resource "aws_route_table_association" "priv2RTassoc" {
    subnet_id = aws_subnet.PrivateSubnet2.id
    route_table_id = aws_route_table.to_nat_instance.id
}
