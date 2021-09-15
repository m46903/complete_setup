# Define Splunk Indexer inside the private subnet
#resource "aws_instance" "indexer" {
#  count         = 3
#  ami           = var.ami
#  instance_type = var.indexer
#  #key_name                    = "content-cyber-range-aws-key"
#  key_name                    = var.key
#  subnet_id                   = aws_subnet.internal-01.id
#  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
#  associate_public_ip_address = false
#  source_dest_check           = false
#  user_data                   = file("userdata_splunk_servers.sh")
#
#
#  tags = {
#    Name = "Indexer-${count.index + 1}"
#  }
#}
#
resource "aws_instance" "search_head" {
  ami                         = var.ami
  instance_type               = var.search_head
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  private_ip                  = "10.10.1.100"
  vpc_security_group_ids      = ["${aws_security_group.splunk_pub_sg.id}"]
  availability_zone           = var.az1
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = file("userdata_splunk_servers.sh")

  tags = {
    Name = "splunk_search_head"
  }
}

resource "aws_instance" "cluster_master" {
  ami                         = var.ami
  instance_type               = var.cluster_master
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-b.id
  private_ip                  = "10.10.2.100"
  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
  availability_zone           = var.az3
  associate_public_ip_address = false
  source_dest_check           = false
  user_data                   = file("userdata_splunk_servers.sh")

  tags = {
    Name = "splunk_cluster_master"
  }
}

resource "aws_instance" "phantom" {
  ami                         = var.ami
  instance_type               = var.phantom
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-a.id
  #private_ip                  = "10.10.1.100"
  vpc_security_group_ids      = ["${aws_security_group.phantom_sg.id}"]
  availability_zone           = var.az1
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = file("userdata_httpd.sh")
  
  root_block_device {
    volume_type = "gp2"
    volume_size = 250
  }

  tags = {Name = "splunk_phantom" }
}

resource "aws_instance" "heavy_forwarder_cribl" {
  ami                         = var.ami
  instance_type               = var.heavy_forwarder
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-b.id
  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
  availability_zone           = var.az3
  associate_public_ip_address = false
  source_dest_check           = false
  user_data                   = file("userdata_cribl.sh")

  root_block_device {
    volume_type = "standard"
    volume_size = 40
  }

  tags = {Name = "splunk_heavy_forwarder_Cribl" }
}

#resource "aws_instance" "heavy_forwarder" {
#  ami                         = var.ami
#  instance_type               = var.heavy_forwarder
#  key_name                    = var.key
#  subnet_id                   = aws_subnet.vpc-1-sub-b.id
#  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
#  availability_zone           = var.az3
#  associate_public_ip_address = false
#  source_dest_check           = false
#  user_data                   = file("userdata_httpd_hostname.sh")
#
#  tags = {Name = "splunk_heavy_forwarder_Cribl" }
#}
#resource "aws_instance" "heavy_forwarder_test" {
#  ami                         = var.ami
#  #instance_type               = var.heavy_forwarder
#  instance_type               = "t2.micro"
#  key_name                    = var.key
#  subnet_id                   = aws_subnet.vpc-1-sub-a.id
#  #private_ip                  = "10.10.1.100"
#  vpc_security_group_ids      = ["${aws_security_group.splunk_pub_sg.id}"]
#  availability_zone           = var.az1
#  #subnet_id                   = aws_subnet.vpc-1-sub-b.id
#  #vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
#  #availability_zone           = var.az3
#  associate_public_ip_address = true
#  source_dest_check           = false
#  user_data                   = file("userdata_httpd_hostname.sh")
#
#  tags = {Name = "splunk_heavy_forwarder_test" }
#}
