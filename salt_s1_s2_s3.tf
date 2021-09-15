resource "aws_instance" "ec2-vpc-1-s1" {
  ami                         = var.ami
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  private_ip                  = "10.10.1.81"
  associate_public_ip_address = true
 # user_data                   = file("userdata_cloud-config.sh")

  tags = {Name  = "salt-s1" }
}

resource "aws_instance" "ec2-vpc-1-s2" {
  ami                         = var.ami
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  private_ip                  = "10.10.1.82"
  associate_public_ip_address = true
 # user_data                   = file("userdata_cloud-config.sh")

  tags = {Name  = "salt-s2" }
}

resource "aws_instance" "ec2-vpc-1-s3" {
  ami                         = var.ami
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  private_ip                  = "10.10.1.83"
  associate_public_ip_address = true
 # user_data                   = file("userdata_cloud-config.sh")

  tags = {Name  = "salt-s3" }
}
