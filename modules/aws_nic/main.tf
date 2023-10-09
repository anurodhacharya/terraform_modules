# Network interface with an ip in the subnet
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
}