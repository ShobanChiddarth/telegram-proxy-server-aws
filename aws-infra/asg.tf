resource "aws_autoscaling_group" "proxy_asg" {
    name = "proxy_asg"

    # will setup lambda based manual overrides later
    min_size = 1
    desired_capacity = 1
    max_size = 2

    vpc_zone_identifier = [ 
        data.aws_availability_zones.AZs[0],
        data.aws_availability_zones.AZs[1]
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
