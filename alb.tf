module "alb_sub_net" {
  source = "./subnet_module"
  for_each = var.alb_subnet_details
  vpc_id = module.vpc.vpc_id
  route_table_id = module.vpc.route_table_id
  availability_zone = "${local.region}${lookup(each.value, "availability_zone")}"
  cidr_block = lookup(each.value, "cidr_block")
}

module "alb_security_group" {
  source = "./sg_module"

  sg_name = "alb_security_group-paulo"
  sg_vpc_id = module.vpc.vpc_id
  security_group_rules = var.alb_sg_rules
}

module "alb" {
  source = "./alb_module"
  vpc_id = module.vpc.vpc_id

  #sg + nets
  lb_security_groups = [module.alb_security_group.sg_id]
  lb_subnets = local.alb_subnets_ids

  #instances
  ami = local.ami
}