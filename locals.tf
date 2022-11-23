locals {
  work = lookup(var.workspaces, terraform.workspace)
  ami = local.work.ami
  region = local.work.region
}