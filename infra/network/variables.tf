variable "namespace" {
  type        = string
  description = "Project identifier used for naming resources."
  default     = "minecraft"
}

variable "environment" {
  type        = string
  description = "Deployment environment name."
  default     = "prod"
}
