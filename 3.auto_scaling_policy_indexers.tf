resource "aws_autoscaling_policy" "asg_policy_indexer1" {
  name                   = "indexer_autoscale_policy1"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.indexer_asg1.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "60"
  }

}
