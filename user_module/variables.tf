variable "users" {
  type        = list(string)
  description = ""
  default = ["Paulo-1", "Paulo-2", "Paulo-3"]
}

variable "user_name" {
  type       = string
}

variable "policy_name" {
  type        = string
  description = ""
  default = "Users-Paulo"
}