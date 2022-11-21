variable "aws_profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "owner" {
  type        = string
  description = ""
  default     = "Paulo"
}

variable "base_instance" {

  type = map(string)

  description = "Instance base details"

  default = {
    name              = "Ubuntu-"
    type              = "t2."
    ami               = "ami-0149b2da6ceec4bb0" # Ubuntu 20.04 free tier
    region            = "us-east-1"
  }
}

variable "instances" {
  type = map(object({
    name              = string
    size              = string
    security_groups   = map(object({
      name              = string
      rules             = map(object({
        rule_type       = string 
        cidr            = list(string)
        from_port       = number
        to_port         = number
        protocol        = string
      }))
    }))
    existing_sg_ids  = list(string)
  }))
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

variable "PUBLIC_KEY_PATH" {
  type = string
}