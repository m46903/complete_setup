resource "aws_autoscaling_group" "indexer_asg1" {
  launch_configuration = aws_launch_configuration.indexer-launch-conf1.id

  vpc_zone_identifier = ["${aws_subnet.vpc-1-sub-b.id}",
  "${aws_subnet.vpc-1-sub-bb.id}", "${aws_subnet.vpc-1-sub-bbb.id}"]


  #load_balancers = [aws_elb.indexer_elb1.name]
  # instances must have http installed & running in order  to 
  # respond to http pings from ELB & for that they need to have
  # a public IP so appache can be downloaded.

  min_size         = 3
  max_size         = 10
  desired_capacity = 3

  tag {
    key                 = "Name"
    value               = "asg-indexer"
    propagate_at_launch = true
  }
}
