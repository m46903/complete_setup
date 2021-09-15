resource "aws_iam_role_policy" "ec2_ci_policy" {
  name = "ec2_ci_policy"
  role = aws_iam_role.ec2_ci_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
  }
  EOF
}

resource "aws_iam_role" "ec2_ci_role" {
  name = "ec2_ci_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "ec2_ci_profile" {
  name = "ec2_ci_profile"
  role = aws_iam_role.ec2_ci_role.name
}
