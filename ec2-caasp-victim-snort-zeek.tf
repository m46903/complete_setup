resource "aws_instance" "victim-snort" {
  ami                    = var.ami
  instance_type          = var.ec2_instance
  key_name               = var.key
  subnet_id              = aws_subnet.vpc-2-sub-b.id
  vpc_security_group_ids = ["${aws_security_group.sg-2.id}"]
  private_ip             = "10.11.2.40"

  tags = { Name     = "ec2-caasp-victim-snort" }
}

resource "aws_instance" "victim-zeek" {
  ami                    = var.ami
  instance_type          = var.ec2_instance
  key_name               = var.key
  subnet_id              = aws_subnet.vpc-2-sub-b.id
  vpc_security_group_ids = ["${aws_security_group.sg-2.id}"]
  private_ip             = "10.11.2.41"

  tags = { Name     = "ec2-caasp-victim-zeek" }
}

resource "aws_instance" "victim-target-01" {
  #count =2
  ami                         = var.ami
  instance_type               = var.nitro
  key_name                    = var.key
  subnet_id              = aws_subnet.vpc-2-sub-b.id
  vpc_security_group_ids = ["${aws_security_group.sg-2.id}"]
  #private_ip                  = "10.10.1.53"
  associate_public_ip_address = false

  tags = { Name     = "ec2-caasp-victim-target-01" }
}