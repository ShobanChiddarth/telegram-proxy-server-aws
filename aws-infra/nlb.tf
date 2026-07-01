resource "aws_lb" "proxy_nlb" {
    name = "proxy-nlb"
    load_balancer_type = "network"
    internal = false

    subnets = [
        aws_subnet.PublicSubnet1.id,
        aws_subnet.PublicSubnet2.id
    ]

    security_groups = [ aws_security_group.nlb_sg.id ]

    enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "proxy_nlb_listener" {
    load_balancer_arn = aws_lb.proxy_nlb.arn

    port = 443
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.proxy_target_group.arn
    }
}


resource "aws_lb_target_group" "proxy_target_group" {
    name = "proxy_target_group"
    port = 443
    protocol = "TCP"

    vpc_id = aws_vpc.TProxyVPC.id

    target_type = "instance"

    health_check {
        protocol = "TCP"
        port = "traffic-port"
    }
}
