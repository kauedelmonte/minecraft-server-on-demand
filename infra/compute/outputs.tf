output "proxy_eip_public_ip" {
  description = "Elastic IP address for the proxy."
  value       = aws_eip.proxy.public_ip
}

output "proxy_instance_id" {
  description = "EC2 instance ID running the proxy host."
  value       = aws_instance.proxy.id
}

output "proxy_cluster_name" {
  description = "ECS cluster name for the proxy."
  value       = aws_ecs_cluster.proxy.name
}

output "backend_cluster_name" {
  description = "ECS cluster name for the backend."
  value       = aws_ecs_cluster.backend.name
}

output "proxy_service_name" {
  description = "ECS service name for the proxy."
  value       = aws_ecs_service.proxy.name
}

output "backend_service_name" {
  description = "ECS service name for the backend."
  value       = aws_ecs_service.backend.name
}

output "backend_asg_name" {
  description = "Autoscaling group name for the backend hosts."
  value       = aws_autoscaling_group.backend.name
}
