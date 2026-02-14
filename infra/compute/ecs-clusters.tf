locals {
  proxy_cluster_name   = "${var.namespace}-${var.environment}-proxy-cluster"
  backend_cluster_name = "${var.namespace}-${var.environment}-backend-cluster"
}

resource "aws_ecs_cluster" "proxy" {
  name = local.proxy_cluster_name
}

resource "aws_ecs_cluster" "backend" {
  name = local.backend_cluster_name
}
