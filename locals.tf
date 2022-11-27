locals {
  work = lookup(var.workspaces, terraform.workspace)
  ami = local.work.ami
  region = local.work.region

  alb_subnets_ids = [for net in module.alb_sub_net : net.subnet_id]
}