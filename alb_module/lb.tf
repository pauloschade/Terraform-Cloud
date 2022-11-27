resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets
}

resource "aws_lb_target_group" "this" {
  name     = var.lb_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  lb_target_group_arn   = aws_lb_target_group.this.arn
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}