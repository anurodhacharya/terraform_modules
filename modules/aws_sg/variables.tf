variable "vpc_id" {
  type = string
}

variable "sg_name" {
  type = map(any)
  default = {
    "Name" = "allow_web"
  }
  
}