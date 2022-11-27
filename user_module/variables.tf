variable "user_name" {
  type       = string
}

variable "policy_name" {
  type        = string
  description = ""
}

variable "is_restricted" {
  type        = bool
  description = ""
}

variable "policy_document" {
  description = ""
  default = {
      Version: "2012-10-17",
      Statement: [
          {
              Effect: "Allow",
              Action: "*",
              Resource: "*"
              Condition: {
                StringEquals: {
                }
             }
          }
      ]
  }
}

variable "rest_policy_document" {
  description = ""
  default = {
  Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: "*",
        Resource: "*",
        Condition: {
          StringEquals: {
          "aws:RequestedRegion": "us-east-1"
          }
        }
      }
    ]
  }
}

