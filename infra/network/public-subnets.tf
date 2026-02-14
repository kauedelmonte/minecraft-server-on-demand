resource "aws_subnet" "public" {
  count                   = 1
  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.namespace}-${var.environment}-public-subnet-${count.index + 1}"
  }
}
