# Installing Ubuntu server
resource "aws_instance" "web_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone

  network_interface {
    device_index = 0
    network_interface_id = var.nic_id
  }

  tags = var.instance_tag
}