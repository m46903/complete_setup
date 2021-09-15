resource "aws_instance" "instance1-sub-a" {
  #count =2
  ami                         = var.ami
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  private_ip                  = "10.10.1.10"
  associate_public_ip_address = true

  tags = {
    Name     = "ec2-vpc-1-pub_sub_a"
    scenario = var.scenario
    env      = "main"
    az       = var.az1
    # Name = "ec2-${count.index + 5}-tgw-vpc-1"
  }

}