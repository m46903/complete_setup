resource "aws_instance" "ec2-caasp-phoenix-01-vpc_1-pub_sub_a" {
  #count =2
  ami                         = var.ami
  instance_type               = var.docker_instance
  key_name                    = var.phoenix_docker_key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.webserver_sg.id}"]
  #private_ip                  = "10.10.1.110"
  associate_public_ip_address = true
  user_data                   = file("userdata_http_docker.sh")

  root_block_device {

    volume_type = "gp2"
    volume_size = 20

  }
 
  tags = { Name = "caasp-phoenix-01" }
}