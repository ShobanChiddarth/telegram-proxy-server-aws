locals {
    proxy_server_user_data =<<-EOF
        #!/bin/bash
        apt-get update
        apt-get upgrade -y

        curl https://get.docker.com | bash
        adduser ubuntu docker

        apt-get install -y unzip
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        ./aws/install

        mkdir -p /data
        PROXY_SECRET=$(aws ssm get-parameter --region ${var.region} --name "${aws_ssm_parameter.proxy_secret.name}" --query "Parameter.Value" --output text)
        echo "$PROXY_SECRET" > /data/secret
        echo "-- -S $PROXY_SECRET" > /data/secret_cmd
        docker pull telegrammessenger/proxy:latest
        docker run -d -p 0.0.0.0:443:443 --name=mtproto-proxy --restart=always -v /data:/data telegrammessenger/proxy:latest
EOF
}


resource "aws_launch_template" "ProxyInstanceLaunchTemplate" {
    image_id = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    key_name = aws_key_pair.management_key_pair.key_name
    vpc_security_group_ids = [ aws_security_group.proxy_server_sg.id ]
    user_data = base64encode(local.proxy_server_user_data)
    update_default_version = true

    iam_instance_profile {
        name = aws_iam_instance_profile.proxy_profile.name
    }

    tags = {
      "Name" = "ProxyServerLaunchTemplate"
    }

    tag_specifications {
    resource_type = "instance"

        tags = {
            Name = "ProxyServer"
        }
    }
}
