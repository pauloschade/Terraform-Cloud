resource "aws_iam_user" "this" {
  name     = var.user_name
}

# resource "aws_iam_user_login_profile" "this" {
#   user    = var.user_name
# }

# resource "aws_iam_user_policy" "this" {
#   name = var.policy_name
#   for_each = aws_iam_user.this
#   user = each.key

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }