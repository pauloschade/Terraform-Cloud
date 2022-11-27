resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone = var.availability_zone
  tags = {
    Name = "Public-subnet-${var.cidr_block}"
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = var.route_table_id
}