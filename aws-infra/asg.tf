resource "aws_autoscaling_group" "proxy_asg" {
    name = "proxy_asg"
    target_group_arns = [ aws_lb_target_group.proxy_target_group.arn ]

    # will setup lambda based manual overrides later
    min_size = 1
    desired_capacity = 1
    max_size = 2

    vpc_zone_identifier = [ 
        aws_subnet.PrivateSubnet1.id,
        aws_subnet.PrivateSubnet2.id
    ]

    launch_template {
        id = aws_launch_template.ProxyInstanceLaunchTemplate.id
        version = "$Latest"
    }

    health_check_type = "ELB"
    health_check_grace_period = 300

    tag {
        key                 = "Name"
        value               = "ProxyServer"
        propagate_at_launch = true
    }
}
