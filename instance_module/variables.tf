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

variable "vpc_security_groups" {
  type        = list(string)
  description = ""
  default = []
}

variable "ssh_key_name" {
  type = string
}