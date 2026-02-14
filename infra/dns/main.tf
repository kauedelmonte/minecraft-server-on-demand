resource "aws_route53_zone" "proxy" {
  name = var.zone_name
}

resource "aws_route53_record" "proxy_a" {
  count   = var.proxy_eip != "" ? 1 : 0
  zone_id = aws_route53_zone.proxy.zone_id
  name    = var.zone_name
  type    = "A"
  ttl     = 60
  records = [var.proxy_eip]
}
