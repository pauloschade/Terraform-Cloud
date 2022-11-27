output "users_details" {
  value = [for user in module.user : "${user.user_name} : ${user.user_password}"]
}