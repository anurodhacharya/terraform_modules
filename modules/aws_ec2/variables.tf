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

variable "nic_id" {
  type = string
}

variable "instance_tag" {
  type = map(any)
  default = {
    "Name" = "web_server"
  }
}