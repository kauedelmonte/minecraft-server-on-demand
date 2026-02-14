output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.default.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "proxy_security_group_id" {
  description = "ID of the proxy security group."
  value       = aws_security_group.proxy.id
}

output "backend_security_group_id" {
  description = "ID of the backend security group."
  value       = aws_security_group.backend.id
}
