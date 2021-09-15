resource "aws_security_group" "sg-2" {

  description = "sg_2 for rdp, ssh & icmp traffic"
  vpc_id      = aws_vpc.vpc-2.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4421
    to_port     = 4421
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["10.11.0.0/16"] # for mirroring 
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 #ingress {
 #  from_port   = 8 # the ICMP type number for 'Echo'
 #  to_port     = 0 # the ICMP code
 #  protocol    = "icmp"
 #  cidr_blocks = ["0.0.0.0/0"]
 #}

 #ingress {
 #  from_port   = 0 # the ICMP type number for 'Echo Reply'
 #  to_port     = 0 # the ICMP code
 #  protocol    = "icmp"
 #  cidr_blocks = ["0.0.0.0/0"]
 #}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sg-2"
    scenario = var.scenario
  }
}
