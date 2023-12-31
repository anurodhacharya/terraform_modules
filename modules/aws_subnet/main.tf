# Subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = var.vpcId
  cidr_block = var.subnet_cidr
  availability_zone = "us-east-1a"

  tags = var.subnet_tag
}