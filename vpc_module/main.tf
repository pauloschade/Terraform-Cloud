resource "aws_vpc" "this" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = "VPC Cloud"
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.publicsCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Internet gateway"
  }
} 

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
    
  tags = {
    Name = "Private Route table"
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.publicdestCIDRblock
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.privatesCIDRblock
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "Private subnet"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
      
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0" 
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.this.id 
  }
    
  tags = {
    Name = "Public Route table"
  }
}