resource "aws_instance" "test_01" {

  ami                         = "ami-0affd4508a5d2481b"
  instance_type               = "t2.micro"
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-b.id
  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
  availability_zone           =  var.az3
  
  }
