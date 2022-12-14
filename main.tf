terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.38"
    }
  }
}


provider "aws" {
  region  = local.region
  profile = var.aws_profile
}

module "vpc" {
  source = "./vpc_module"
  aws_region = local.region
}

module "instance" {
  source = "./instance_module"

  for_each = var.instances

  instance_name = "${lookup(var.base_instance, "name")}${lookup(each.value, "name", "default")}"
  instance_type = "${lookup(var.base_instance, "type")}${lookup(each.value, "size", "tiny")}"
  instance_ami  = local.ami

  vpc_subnet_id = module.vpc.subnet_id
  vpc_id = module.vpc.vpc_id
  security_groups = lookup(each.value, "security_groups", null)
  #vpc_security_groups = substr(each.key, 0, 3) == "web" ? [module.security_groups.web] : [module.security_groups.db]
  # ssh_key_name = aws_key_pair.this.id
}

# resource "aws_key_pair" "this" {
#   key_name = "projeto-cloud"
#   public_key = file(var.PUBLIC_KEY_PATH)
# }