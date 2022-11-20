terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.38"
    }
  }
}


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source = "./vpc_module"
}

module "security_groups" {
  source = "./security_module"
  vpc_id = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  subnet_cidr = module.vpc.subnet_cidr
}

module "instance" {
  source = "./instance_module"

  for_each = var.instances

  instance_name = "${lookup(var.base_instance, "name")}${lookup(each.value, "name", "default")}"
  instance_type = "${lookup(var.base_instance, "type")}${lookup(each.value, "size", "tiny")}"
  instance_ami  = lookup(var.base_instance, "ami")

  vpc_subnet_id = module.vpc.subnet_id
  vpc_security_groups = [module.security_groups.web_id]

  ssh_key_name = aws_key_pair.this.id
}

resource "aws_key_pair" "this" {
  key_name = "projeto-cloud"
  public_key = file(var.PUBLIC_KEY_PATH)
}

module "user" {
  source = "./user_module"
}