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
        description = "from :443 of NLB to EC2s :443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ aws_vpc.TProxyVPC.cidr_block ]
    }
}

resource "aws_security_group" "bastion_sg" {
    name = "bastion_sg"
    description = "Allow SSH from public IP/VPN"
    vpc_id = aws_vpc.TProxyVPC.id

    ingress {
        description = "allow ssh from my public ip"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ var.my_public_ip ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_security_group" "proxy_server_sg" {
    name = "proxy_server_sg"
    description = "Allow :443 from NLB, :22 from management"
    vpc_id = aws_vpc.TProxyVPC.id

    ingress {
        description = "allow ssh from management"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.bastion_sg.id ]
    }

    ingress {
        description = "allow :443 from NLB"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = [ aws_security_group.nlb_sg.id ]
    }

    egress {
        description = "allow all"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

}
