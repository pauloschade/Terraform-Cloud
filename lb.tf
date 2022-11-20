# resource "aws_lb" "this" {
#   name            = "Terraform-ALB"
#   security_groups = [module.security_groups.lb_id]
#   subnets         = [module.vpc.subnet_id]

#   tags = { Name = "Terraform ALB" }
# }

# resource "aws_lb_target_group" "this" {
#   name     = "ALB-TG"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id

#   health_check {
#     path              = "/"
#     healthy_threshold = 2
#   }
# }

# resource "aws_lb_listener" "this" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this.arn
#   }
# }