resource aws_launch_configuration "phoenix-launch-conf" {
  #name = "phoenix-launch"
  image_id        = var.ami
  instance_type   = var.docker_instance
  security_groups = [aws_security_group.webserver_sg.id]
  #key_name        = var.key
  key_name  = var.phoenix_docker_key
  user_data = file("userdata_docker_hosts.sh")


  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
  }

}
