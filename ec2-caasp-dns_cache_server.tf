#CAASP-176 Create DNS caching server in CaaSP
resource "aws_instance" "dns_cache_server" {
  #count =2
  ami                         = var.ami
  instance_type               = var.ec2_instance
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  vpc_security_group_ids      = ["${aws_security_group.sg-1.id}"]
  #private_ip                  = "10.10.1.10"
  #associate_public_ip_address = true
  tags = { Name     = "dns_cache_server" }
}

resource "aws_eip" "dns_cache_server" {
    instance = aws_instance.dns_cache_server.id
    vpc = true
    tags = { Name     = "dns_cache_server" }
}