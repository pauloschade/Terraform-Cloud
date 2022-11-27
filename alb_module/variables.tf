## ---------------------------------------------------------------------------
## LOAD BALANCER
variable "lb_name" {
  type        = string
  default = "lb-paulo"
}

variable "lb_tg_name" {
  type        = string
  default = "lb-tg-paulo"
}

variable "lb_security_groups" {
  type        = list(string)
}

variable "lb_subnets" {
  type        = list(string)
}

## ---------------------------------------------------------------------------
## ASG
variable "max_size" {
  type        = number
  default = 5
}

variable "min_size" {
  type        = number
  default = 1
}

variable "desired_capacity" {
  type        = number
  default = 3
}

variable "scale_down_adjustment" {
  type        = number
  default = "-1"
}

variable "scale_up_adjustment" {
  type        = number
  default = 1
}

# variable "alb_security_group" {
#   type        = string
# }
## ---------------------------------------------------------------------------
## INSTANCE

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

# variable "alb_instances_security_groups" {
#   type        = list(string)
# }

variable "ami" {
  type        = string
}


## ---------------------------------------------------------------------------
## GENERAL

variable "vpc_id" {
  type        = string
}
