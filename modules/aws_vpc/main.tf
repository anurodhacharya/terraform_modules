# VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod-vpc"
  }
}