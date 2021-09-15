resource aws_launch_configuration "indexer-launch-conf1" {
  #name = "indexer-launch"
  image_id        = var.ami
  instance_type   = var.indexer
  security_groups = [aws_security_group.private_sg.id]
  key_name        = var.key
  user_data       = file("userdata_splunk_servers.sh")


  lifecycle {
    create_before_destroy = true
  }

  root_block_device {

    volume_type = "gp2"
    volume_size = 10

  }

  ebs_block_device {

    device_name           = "/dev/sdd"
    volume_type           = "gp2"
    volume_size           = 200
    delete_on_termination = true

  }
}
