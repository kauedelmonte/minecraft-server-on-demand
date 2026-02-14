variable "zone_name" {
  type        = string
  description = "Public hosted zone name (subdomain) for the proxy."
}

variable "proxy_eip" {
  type        = string
  description = "Proxy Elastic IP address used in the A record."
  default     = ""
}
