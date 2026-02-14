resource "aws_subnet" "private" {
  count      = 1
  vpc_id     = aws_vpc.default.id
  cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index + 1)

  tags = {
    Name = "${var.namespace}-${var.environment}-private-subnet-${count.index + 1}"
  }
}
