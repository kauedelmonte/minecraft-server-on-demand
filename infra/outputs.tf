output "vpc_id" {
  description = "ID of the VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.network.private_subnet_ids
}

output "proxy_security_group_id" {
  description = "ID of the proxy security group."
  value       = module.network.proxy_security_group_id
}

output "backend_security_group_id" {
  description = "ID of the backend security group."
  value       = module.network.backend_security_group_id
}

output "dns_zone_id" {
  description = "Route 53 hosted zone ID for the proxy subdomain."
  value       = module.dns.zone_id
}

output "dns_name_servers" {
  description = "Name servers to delegate the subdomain at the registrar."
  value       = module.dns.name_servers
}

output "proxy_record_fqdn" {
  description = "FQDN of the proxy A record (if created)."
  value       = module.dns.proxy_record_fqdn
}

output "proxy_eip_public_ip" {
  description = "Elastic IP address for the proxy."
  value       = module.compute.proxy_eip_public_ip
}

output "proxy_instance_id" {
  description = "EC2 instance ID running the proxy host."
  value       = module.compute.proxy_instance_id
}

output "proxy_cluster_name" {
  description = "ECS cluster name for the proxy."
  value       = module.compute.proxy_cluster_name
}

output "backend_cluster_name" {
  description = "ECS cluster name for the backend."
  value       = module.compute.backend_cluster_name
}

output "proxy_service_name" {
  description = "ECS service name for the proxy."
  value       = module.compute.proxy_service_name
}

output "backend_service_name" {
  description = "ECS service name for the backend."
  value       = module.compute.backend_service_name
}

output "backend_asg_name" {
  description = "Autoscaling group name for the backend hosts."
  value       = module.compute.backend_asg_name
}
