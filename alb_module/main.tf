resource "aws_autoscaling_group" "this" {
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier  = var.lb_subnets
  
}