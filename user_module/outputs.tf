output "users_arns" {
  value = { for k, v in aws_iam_user.this : k => v.arn }
}