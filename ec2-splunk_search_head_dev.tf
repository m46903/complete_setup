resource "aws_instance" "search_head_dev" {
  ami                         = var.ami
  # "ami-0affd4508a5d2481b"
  instance_type               = var.search_head
  key_name                    = var.key
  subnet_id                   = aws_subnet.vpc-1-sub-b.id
  private_ip                  = "10.10.2.110"
  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
  availability_zone           =  var.az3
  #associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = file("userdata_splunk_sh_dev.sh")
  # Note:
  # Add following line from "userdata_splunk_sh_dev.sh" manually in "/etc/fstab" file 
  # /dev/xvdd /opt/splunk ext4 defaults,nofail 0 0
  
  tags = {  Name = "splunk_search_head_dev"  }

 ebs_block_device {
   #device_name           = "/dev/sdd"
   device_name           = "/dev/xvdd"
   volume_type           = "gp2"
   volume_size           = 200
   delete_on_termination = true
 }
}
