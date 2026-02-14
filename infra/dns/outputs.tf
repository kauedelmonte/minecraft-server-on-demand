output "zone_id" {
  description = "Route 53 hosted zone ID."
  value       = aws_route53_zone.proxy.zone_id
}

output "name_servers" {
  description = "Name servers to delegate the subdomain at the registrar."
  value       = aws_route53_zone.proxy.name_servers
}

output "proxy_record_fqdn" {
  description = "FQDN of the proxy A record (if created)."
  value       = try(aws_route53_record.proxy_a[0].fqdn, null)
}
