resource "aws_instance" "salt_master" {
  #count =2
  ami                         = var.ami
  instance_type               = var.salt_master
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.splunk_pub_sg.id}"]
  private_ip                  = "10.10.1.101"
  associate_public_ip_address = true

  tags = {
    Name = "salt_master"
    # Name = "ec2-${count.index + 5}-tgw-vpc-1"
  }

}