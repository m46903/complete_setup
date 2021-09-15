resource "aws_security_group" "allow_psql_vpc_2" {
  name        = "allow_psql_vpc_2"
  description = "allow_psql_vpc_2"
  vpc_id      = aws_vpc.vpc-2.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    #security_groups = [aws_security_group.webserver_sg.id] # allowing access from our instance
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow-psql"
  }
}
