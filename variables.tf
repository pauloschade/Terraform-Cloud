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

variable "aws_alternate_region" {
  type        = string
  description = ""
  default     = "us-west-1"
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
  }))
}

variable "users" {
  type = map(bool)
}

variable "workspaces" {
  type = map(object({
    ami            = string
    region         = string
  }))
  default = {
    "default" = {
      ami = "ami-0149b2da6ceec4bb0"
      region = "us-east-1"
    }
    "alternate" = {
      ami = "ami-03f6d497fceb40069"
      region = "us-west-1"
    }
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# ALB
variable "alb_subnet_details" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
  default = {
    "zone_a" = {
      cidr_block = "10.0.4.0/24"
      availability_zone = "a"
    },

    "zone_b" = {
      cidr_block = "10.0.8.0/24"
      availability_zone = "b"
    }

    }
}

variable "alb_sg_rules" {
  type       = map(object({
      rule_type       = string 
      cidr            = list(string)
      from_port       = number
      to_port         = number
      protocol        = string
    }))

  default = {
    "ingress" = { 
      rule_type = "ingress"
      cidr = ["0.0.0.0/0"]
      from_port = 80
      to_port     = 80
      protocol = "tcp"
    },
    "egress" = { 
      rule_type = "egress"
      cidr = ["0.0.0.0/0"]
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------

# variable "PUBLIC_KEY_PATH" {
#   type = string
# }