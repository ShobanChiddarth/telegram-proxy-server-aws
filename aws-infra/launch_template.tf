resource "aws_launch_template" "ProxyInstanceLaunchTemplate" {
    image_id = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    key_name = aws_key_pair.proxy_server_key_pair.key_name
    vpc_security_group_ids = [ aws_security_group.proxy_server_sg.id ]
    user_data = base64encode(join("\n", [var.user_data.base, var.user_data.docker_install, var.user_data.proxy_server])) # will take care of this later
    update_default_version = true

    iam_instance_profile {
        name = aws_iam_instance_profile.proxy_profile.name
    }

    tags = {
      "Name" = "ProxyServerLaunchTemplate"
    }
}
