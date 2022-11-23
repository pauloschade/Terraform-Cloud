resource "aws_subnet" "pub" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.publicsCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.this.id
      
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0" 
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.pub.id 
  }
    
  tags = {
    Name = "Public Route table"
  }
}

resource "aws_internet_gateway" "pub" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Internet gateway"
  }
}

resource "aws_route" "pub" {
  route_table_id         = aws_route_table.pub.id
  destination_cidr_block = var.publicdestCIDRblock
  gateway_id             = aws_internet_gateway.pub.id
}

resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.pub.id
}