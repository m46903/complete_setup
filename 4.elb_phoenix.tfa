resource "aws_elb" "phoenix_elb" {
  name = "vpc-1-phoenix-elb"

  security_groups = ["${aws_security_group.webserver_sg.id}",
  "${aws_security_group.elb_sg.id}"]


  subnets = ["${aws_subnet.vpc-1-sub-a.id}",
  "${aws_subnet.vpc-1-sub-aa.id}"]


  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
  health_check {

    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 5
    target              = "HTTP:${var.server_port}/"
  }
}


