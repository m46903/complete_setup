resource "aws_instance" "ec2-vpc_1-pub_sub_a-profile-ex1" {
  # this  ec2 has a profile attached to it which gives it full access to S3

  ami                         = var.ami
  instance_type               = var.salt_master
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_ci_profile.name
  user_data = file("userdata_docker_ci.sh")

  tags = {
    Name     = "caasp-build-01"
    }

  root_block_device {
    volume_type = "gp2"
    volume_size = 24
  }
}