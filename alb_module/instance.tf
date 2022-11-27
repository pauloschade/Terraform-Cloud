resource "aws_launch_configuration" "this" {
  name_prefix     = "ASG-Paulo"
  image_id        = var.ami
  instance_type   = var.instance_type
  user_data       = file("ec2_setup.sh")
  security_groups = [aws_security_group.this.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "this" {
  name = "asg-sg-instances"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = var.lb_security_groups
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = var.lb_security_groups
  }

  vpc_id = var.vpc_id
}