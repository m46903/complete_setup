## 1 ##
resource "aws_lb" "cribl-alb" {
  name     = "splunk-cribl-alb"
  internal = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.webserver_sg.id}",
  "${aws_security_group.private_sg.id}","${aws_security_group.elb_sg.id}"]

  #subnets = ["${aws_subnet.vpc-1-sub-a.id}",
  #"${aws_subnet.vpc-1-sub-b.id}","${aws_subnet.vpc-1-sub-aa.id}"]

  subnets = ["${aws_subnet.vpc-1-sub-a.id}",
  "${aws_subnet.vpc-1-sub-aa.id}","${aws_subnet.vpc-1-sub-aaa.id}"]

  tags = { Name = "splunk-cribl-alb" }
}

# 2##
#resource "aws_lb_listener" "cribl-alb-listner-80" {
#  load_balancer_arn = aws_lb.cribl-alb.arn
#  port              = 80
#  protocol          = "HTTP"
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.splunk-cribl-tg.arn
#  }
#}

resource "aws_lb_listener" "cribl-alb-listner" {
  load_balancer_arn = aws_lb.cribl-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  certificate_arn   = "arn:aws:acm:us-east-1:952430311316:certificate/dd923271-af0b-4367-b0c4-fb54556f5420"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.splunk-cribl-tg.arn
  }
}

## 3##
resource "aws_lb_target_group" "splunk-cribl-tg" {
  
  name        = "cribl-tg"
  port        = 600
  #protocol    = "HTTPS"
  protocol    = "HTTP"
  target_type = "instance"
  #vpc_id      = "${var.vpc_id}"
  vpc_id      = aws_vpc.vpc-1.id
  deregistration_delay       = 10
  
  health_check {
    interval            = 10
    #path                = "/"
    path                = "/var/www/html/index.html"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

## 4##
resource "aws_lb_target_group_attachment" "cribl-tg-attachment1" {
  target_group_arn = aws_lb_target_group.splunk-cribl-tg.arn
  #target_id        = "${var.instance1_id}"
  target_id        = aws_instance.heavy_forwarder_cribl.id
  port             = 9000
}

#resource "aws_lb_target_group_attachment" "cribl-tg-attachment2" {
#  target_group_arn = aws_lb_target_group.cribl-tg.arn
#  #target_id        = "${var.instance1_id}"
#  target_id        = aws_instance.ec2-caasp-phoenix-02-vpc_1-pub_sub_a.id
#  port             = 80
#}

