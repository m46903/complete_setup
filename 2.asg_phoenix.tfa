resource "aws_autoscaling_group" "phoenix_asg" {
  launch_configuration = aws_launch_configuration.phoenix-launch-conf.id


  vpc_zone_identifier = ["${aws_subnet.vpc-1-sub-a.id}",
  "${aws_subnet.vpc-1-sub-aa.id}"]

  load_balancers = [aws_elb.phoenix_elb.name]

  min_size         = 2
  max_size         = 10
  desired_capacity = 2

  tag {
    key                 = "Name"
    value               = "asg-phoenix-docker-host"
    propagate_at_launch = true
  }
}
