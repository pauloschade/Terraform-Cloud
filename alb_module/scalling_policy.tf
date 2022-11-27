## ---------------------------------------------------------------------------------------------------------------------
## SCALE DOWN
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "ASG scale-down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_down_adjustment
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization for ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "ASG alarm_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = 10
  evaluation_periods  = 2
  period              = 120
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## SCALE UP

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "ASG scale-up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_up_adjustment
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "Monitors CPU utilization for ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "ASG alarm_scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = 10
  evaluation_periods  = 2
  period              = 120
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}