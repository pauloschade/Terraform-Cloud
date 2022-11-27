# output "name" {
#   value = aws_iam_user_login_profile.this.user
# }

output "user_password" {
  value = aws_iam_user_login_profile.this.password
}

output "user_name" {
  value = aws_iam_user.this.name
}