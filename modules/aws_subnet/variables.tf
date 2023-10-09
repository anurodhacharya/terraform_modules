variable "vpc_id" {
  type = string
}

variable "subnet_cidr" {
  type = string
  default = "172.16.10.0/24"
}

variable "subnet_tag" {
  type = map(any)
  default = {
    "Name" = "prod-subnet"
  }
}

variable "vpc_tag" {
  type = map(any)
  default = {
    "Name" = "prod-vpc"
  }
}

variable "sg_name" {
  type = map(any)
  default = {
    "Name" = "allow_web"
  }
}