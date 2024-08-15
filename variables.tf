variable "role_name" {
  type        = string
  description = "Name of the role"
}

variable "account_id" {
  description = "Account from where this role will be assumed"
}

variable "iam_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
}