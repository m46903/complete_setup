resource "aws_instance" "instance1-sub-bb" {
  ami                    = var.ami
  instance_type          = var.ec2_instance
  key_name               = var.key
  subnet_id              = aws_subnet.vpc-1-sub-bb.id
  vpc_security_group_ids = ["${aws_security_group.sg-1.id}"]
  private_ip             = "10.10.3.30"
  user_data              = file("userdata_splunk_servers.sh")
  #associate_public_ip_address = true

  tags = { Name = "ec2-vpc-1-private_sub_bb-30" }

  root_block_device {
    volume_type = "standard"
    volume_size = 15
  }

  ebs_block_device {
    device_name           = "/dev/sdd"
    volume_type           = "standard"
    volume_size           = 20
    delete_on_termination = true
  }
}