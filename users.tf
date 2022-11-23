module "user" {
  source = "./user_module"
  for_each = toset(var.users)
  user_name = each.key
}