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

variable "sg_name" {
  type = map(any)
  default = {
    "Name" = "allow_web"
  }
}

variable "private_ips" {
  type = list(string)
  default = ["172.16.10.100"]
}

variable "associate_private_ips" {
  type = string
  default = "172.16.10.100"
}

variable "instance_ami" {
  type = string
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
  
}

variable "instance_tag" {
  type = map(any)
  default = {
    "Name" = "web_server"
  }
}