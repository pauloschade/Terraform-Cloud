resource "aws_security_group" "this" {
  name   = var.sg_name
  vpc_id = var.sg_vpc_id
  tags = { Name = var.sg_name }
}

module "sg_rules" {
  source = "../sg_rules_module"
  for_each = var.security_group_rules
  sg_id = aws_security_group.this.id
  sg_rule_type = lookup(each.value, "rule_type", "ingress")
  sg_rule_from_port = lookup(each.value, "from_port", null)
  sg_rule_to_port = lookup(each.value, "to_port", null)
  sg_rule_protocol = lookup(each.value, "protocol", null)
  sg_rule_cidr_blocks = lookup(each.value, "cidr", null)
}