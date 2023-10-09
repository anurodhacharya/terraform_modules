# VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = var.vpc_tag
}

variable "vpc_cidr" {
  type = string
  default = "172.16.0.0/16"
}

variable "vpc_tag" {
  type = map(any)
  default = {
    "Name" = "prod-vpc"
  }
}