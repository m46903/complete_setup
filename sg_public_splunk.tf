resource "aws_security_group" "splunk_pub_sg" {

  description = "public splunk_sg"
  vpc_id      = aws_vpc.vpc-1.id
  
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_sg.id}"]
    cidr_blocks = ["10.0.0.0/8"]
    #cidr_blocks = [var.my_public_ip]
  }
 
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 9997
    to_port     = 9998
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
 
 #ingress {
 #  from_port   = 80
 #  to_port     = 80
 #  protocol    = "tcp"
 #  cidr_blocks = ["0.0.0.0/0"]
 #}
  ingress {
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Splunk Public SG" }
}