resource "aws_security_group" "nlb_sg" {
    name = "nlb_sg"
    description = "Allow :443 from internet to NLB"
    vpc_id = aws_vpc.TProxyVPC.id

    ingress {
        description = ":443 from internet"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        description = "from :443 of NLB to EC2's :443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ aws_vpc.TProxyVPC.cidr_block ]
    }
}


resource "aws_security_group" "proxy_server_security_group" {
  
}