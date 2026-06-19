resource "aws_vpc" "singleEC2VPC" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "singleEC2VPC"
  }

}

resource "aws_internet_gateway" "singleEC2igw" {
  vpc_id = aws_vpc.singleEC2VPC.id

  tags = {
    "Name" = ""
  }

}