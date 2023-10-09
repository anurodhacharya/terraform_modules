variable "subnet_id" {
  type = string
}

variable "private_ips" {
  type = list(string)
  default = ["172.16.10.100"]
}

variable "associate_private_ips" {
  type = string
  default = "172.16.10.100"
}

