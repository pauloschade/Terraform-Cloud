locals {
  security_group_created_ids = [for k, v in module.sg : v.sg_id]
  security_group_ids = [for s in var.existing_sg_ids : concat(local.security_group_created_ids, [s])]
}
