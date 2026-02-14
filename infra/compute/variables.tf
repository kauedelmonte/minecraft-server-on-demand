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

variable "ec2_public_key" {
  type        = string
  description = "Public key used for EC2 instance SSH access."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for EC2 instances."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for EC2 instances."
}

variable "proxy_security_group_id" {
  type        = string
  description = "Security group ID for the proxy."
}

variable "backend_security_group_id" {
  type        = string
  description = "Security group ID for the backend."
}

variable "proxy_instance_type" {
  type        = string
  description = "EC2 instance type for the proxy host."
  default     = "t4g.nano"
}

variable "backend_instance_type" {
  type        = string
  description = "EC2 instance type for the backend host."
  default     = "t4g.large"
}

variable "proxy_container_image" {
  type        = string
  description = "Container image for the Velocity proxy."
}

variable "backend_container_image" {
  type        = string
  description = "Container image for the Paper backend."
}

variable "proxy_container_cpu" {
  type        = number
  description = "CPU units for the proxy container."
  default     = 128
}

variable "proxy_container_memory" {
  type        = number
  description = "Memory (MiB) for the proxy container."
  default     = 384
}

variable "backend_container_cpu" {
  type        = number
  description = "CPU units for the backend container."
  default     = 1024
}

variable "backend_container_memory" {
  type        = number
  description = "Memory (MiB) for the backend container."
  default     = 8192
}

variable "proxy_container_port" {
  type        = number
  description = "TCP port for the proxy container."
  default     = 25565
}

variable "proxy_bedrock_port" {
  type        = number
  description = "UDP port for Bedrock/Geyser on the proxy."
  default     = 19132
}

variable "backend_container_port" {
  type        = number
  description = "TCP port for the backend container."
  default     = 25565
}

variable "proxy_desired_count" {
  type        = number
  description = "Desired task count for the proxy service."
  default     = 1
}

variable "backend_desired_count" {
  type        = number
  description = "Desired task count for the backend service."
  default     = 0
}

variable "backend_asg_min" {
  type        = number
  description = "Minimum size for the backend ASG."
  default     = 0
}

variable "backend_asg_max" {
  type        = number
  description = "Maximum size for the backend ASG."
  default     = 1
}

variable "backend_asg_desired" {
  type        = number
  description = "Desired size for the backend ASG."
  default     = 0
}

variable "log_retention_in_days" {
  type        = number
  description = "CloudWatch Logs retention in days."
  default     = 14
}
