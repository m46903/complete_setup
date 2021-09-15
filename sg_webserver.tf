resource "aws_security_group" "webserver_sg" {
  name        = "webserver sg"
  description = "webserver sg"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    #cidr_blocks = [var.my_public_ip]
    cidr_blocks = ["10.11.0.0/16"]
  }
ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    #cidr_blocks = ["10.11.0.0/16"]
    cidr_blocks = ["10.11.0.0/16","10.10.1.0/24", "10.10.10.0/24"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public subnet SG"
  }

}

