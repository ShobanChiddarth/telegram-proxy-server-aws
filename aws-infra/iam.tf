# This file manages
# 1. IAM role
# 2. IAM policy for that role
# 3. Attaching IAM policy to that role
# 4. creatingthe instance profile (final)

resource "aws_iam_role" "proxy_server_role" {
  name = "proxy_server_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "proxy_server_ssm_policy" {
  name = "proxy-server-ssm-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ssm:GetParameter"
        ]

        Resource = aws_ssm_parameter.proxy_secret.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_read_ssm_policy_to_role" {
    role = aws_iam_role.proxy_server_role.name
    policy_arn = aws_iam_policy.proxy_server_ssm_policy.arn
}

resource "aws_iam_instance_profile" "proxy_profile" {
    name = "proxy_iam_profile"
    role = aws_iam_role.proxy_server_role.name
}
