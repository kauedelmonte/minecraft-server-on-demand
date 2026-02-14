resource "aws_key_pair" "default" {
  key_name   = "${var.namespace}-${var.environment}-key-pair"
  public_key = var.ec2_public_key
}
