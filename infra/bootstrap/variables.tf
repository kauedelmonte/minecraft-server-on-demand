variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type     = string
  default  = null
  nullable = true
}

variable "account_alias" {
  type        = string
  description = "The desired AWS account alias."
}
