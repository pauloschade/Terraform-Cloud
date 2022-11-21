variable "sg_id" {
  type        = string
}

variable "sg_rule_type" {
  type        = string
}

variable "sg_rule_from_port" {
  type        = number
}

variable "sg_rule_to_port" {
  type        = number
}

variable "sg_rule_protocol" {
  type        = string
}

variable "sg_rule_cidr_blocks" {
  type        = list(string)
}