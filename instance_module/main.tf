# resource "aws_instance" "web" {
#   ami           = var.instance_ami
#   instance_type = var.instance_type
#   tags = {
#       Name = var.instance_name
#   }
#   vpc_security_group_ids = var.vpc_security_groups
#   subnet_id = var.vpc_subnet_id
#   key_name = var.ssh_key_name
# }

module "sg" {
  source = "../sg_module"
  for_each = var.security_groups
  sg_vpc_id = var.vpc_id
  sg_name = each.key
  security_group_rules = lookup(each.value, "rules", null)
}

resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags = {
      Name = var.instance_name
  }
  vpc_security_group_ids = local.security_group_ids
  subnet_id = var.vpc_subnet_id
  key_name = var.ssh_key_name
}