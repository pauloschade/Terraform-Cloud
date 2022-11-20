output "subnet_id" {
  value = aws_subnet.this.id
}

output "subnet_cidr" {
  value = var.publicsCIDRblock
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = var.vpcCIDRblock
}

# output "security_groups" {
#   value = [aws_security_group.ssh-allowed.id]
# }