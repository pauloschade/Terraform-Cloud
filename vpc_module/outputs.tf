output "subnet_id" {
  value = aws_subnet.pub.id
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

output "priv_subnet_id" {
  value = aws_subnet.priv.id
}

output "route_table_id" {
  value = aws_route_table.pub.id
}