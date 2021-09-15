resource "aws_security_group" "allow_psql" {
  name        = "allow_psql"
  description = "allow_psql"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_sg.id] # allowing access from our instance
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
