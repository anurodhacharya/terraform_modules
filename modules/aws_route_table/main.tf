# Custom Route Table
resource "aws_route_table" "route-table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }
  tags = {
    Name = "route-table"
  }
}

# Associating subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.route-table.id
}