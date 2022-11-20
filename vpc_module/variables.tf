variable "instanceTenancy" {
    type    = string
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    type    = string
    default = "10.0.0.0/16"
}
variable "publicsCIDRblock" {
    type    = string
    default = "10.0.1.0/24"
}
variable "privatesCIDRblock" {
    type    = string
    default = "10.0.2.0/24"
}
variable "publicdestCIDRblock" {
    type    = string
    default = "0.0.0.0/0"
}
variable "localdestCIDRblock" {
    type    = string
    default = "10.0.0.0/16"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}

variable "aws_region" {
    type    = string
    default = "us-east-1"
}