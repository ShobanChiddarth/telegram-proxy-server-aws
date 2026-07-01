resource "aws_lb" "proxy_nlb" {
    name = "proxy_nlb"
    load_balancer_type = "network"
    internal = false

    subnets = [
        aws_subnet.PublicSubnet1.id,
        aws_subnet.PublicSubnet2.id
    ]

    security_groups = [ aws_security_group.nlb_sg.id ]

    enable_cross_zone_load_balancing = true
}
