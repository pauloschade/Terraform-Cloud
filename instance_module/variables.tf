variable "instance_ami" {
  type        = string
  description = ""
}

variable "instance_name" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = ""
}

variable "vpc_subnet_id" {
  type        = string
  description = ""
  default = null
}

variable "vpc_id" {
  type        = string
  description = ""
  default = null
}

# variable "vpc_security_groups" {
#   type        = list(string)
#   description = ""
#   default = []
# }

variable "ssh_key_name" {
  type = string
}

variable "existing_sg_ids" {
  type = list(string)
  default = ["id-1", "id-2"]
}

variable "security_groups" {
  type = map(object({
    name              = string
    rules             = map(object({
      rule_type       = string 
      cidr            = list(string)
      from_port       = number
      to_port         = number
      protocol        = string
    }))
  }))
}