variable "vpc_id" {
  type       = string
}

variable "cidr_block" {
    type    = string
    default = "0.0.0.0/0"
}

variable "aws_region" {
    type    = string
    default = "us-east-1"
}

variable "mapPublicIP" {
    default = true
}

variable "publicdestCIDRblock" {
    type    = string
    default = "0.0.0.0/0"
}

variable "route_table_id" {
    type    = string
}

variable "availability_zone" {
    type    = string
}