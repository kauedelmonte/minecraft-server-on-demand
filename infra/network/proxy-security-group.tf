resource "aws_security_group" "proxy" {
  name   = "${var.namespace}-${var.environment}-proxy-sg"
  vpc_id = aws_vpc.default.id
}

resource "aws_vpc_security_group_egress_rule" "proxy_egress" {
  security_group_id = aws_security_group.proxy.id
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "proxy_minecraft_java" {
  security_group_id = aws_security_group.proxy.id
  ip_protocol       = "tcp"
  from_port         = 25565
  to_port           = 25565
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "proxy_minecraft_bedrock" {
  security_group_id = aws_security_group.proxy.id
  ip_protocol       = "udp"
  from_port         = 19132
  to_port           = 19132
  cidr_ipv4         = "0.0.0.0/0"
}
