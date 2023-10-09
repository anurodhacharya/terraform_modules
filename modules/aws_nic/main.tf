# Network interface with an ip in the subnet
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["172.16.10.100"]
  security_groups = [aws_security_group.allow_web.id]
}

# Elastic IP to the network interface that was created
resource "aws_eip" "one" {
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "172.16.10.100"
  depends_on = [aws_internet_gateway.gw]
}