resource "aws_instance" "kali_linux-sub-b" {
  ami                    = var.kali_linux
  instance_type          = var.ec2_instance
  key_name               = var.key
  subnet_id              = aws_subnet.vpc-1-sub-b.id
  vpc_security_group_ids = ["${aws_security_group.sg-1.id}"]
  #private_ip             = "10.10.2.20"
  #associate_public_ip_address = true

  tags = {
    Name     = "ec2-kali_linux-vpc_1-sub_b"
    scenario = var.scenario
    env      = "main"
    az       = var.az1

  }
}