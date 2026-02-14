resource "aws_instance" "proxy" {
  ami                         = data.aws_ami.ecs_al2023_arm64.id
  instance_type               = var.proxy_instance_type
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [var.proxy_security_group_id]
  key_name                    = aws_key_pair.default.key_name
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance.name
  associate_public_ip_address = false
  user_data = templatefile("${path.module}/user-data-ecs.sh", {
    cluster_name = local.proxy_cluster_name
  })

  tags = {
    Name        = "${var.namespace}-${var.environment}-proxy-ec2"
    Environment = var.environment
  }
}

resource "aws_eip" "proxy" {
  domain = "vpc"

  tags = {
    Name        = "${var.namespace}-${var.environment}-proxy-eip"
    Environment = var.environment
  }
}

resource "aws_eip_association" "proxy" {
  allocation_id = aws_eip.proxy.id
  instance_id   = aws_instance.proxy.id
}
