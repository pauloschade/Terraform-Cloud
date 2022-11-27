module "user" {
  source = "./user_module"
  for_each = var.users
  user_name = each.key
  is_restricted = each.value
  policy_name = "user_policy-${each.key}"
}

# module "user_policy" {
#   source = "./user_policy_module"
#   for_each = toset(var.users)
#   user_name = each.key
#   policy_name = "user_policy"
#   policy = data.aws_iam_policy_document.user_policy.json
# }