variable "sg_vpc_id" {
  type        = string
}

variable "sg_name" {
  type        = string
}

variable "security_group_rules" {
  type = map(object({
    rule_type       = string 
    cidr            = list(string)
    from_port       = number
    to_port         = number
    protocol        = string
  }))
}