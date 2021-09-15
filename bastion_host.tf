resource "aws_instance" "bastion_host" {

  ami                         = var.bastion_host
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.bastion_sg.id}"]
  private_ip                  = "10.10.1.102"
  associate_public_ip_address = true

  tags = { Name = "bastion_aws-ami" }

  root_block_device {
    volume_type = "standard"
    volume_size = 50
  }
#ssh -i content-cyber-range-aws-key ec2-user@34.203.189.195
}
