resource "aws_subnet" "priv" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.privatesCIDRblock
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "Private subnet"
  }
}

resource "aws_route_table" "priv" {
  vpc_id = aws_vpc.this.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0" 
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.pub.id 
  }
    
  tags = {
    Name = "Private Route table"
  }
}

resource "aws_route_table_association" "priv" {
  subnet_id      = aws_subnet.priv.id
  route_table_id = aws_route_table.priv.id
}