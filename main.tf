provider "aws" {
  region     = "us-east-1"
}

# VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod-vpc"
  }
}

# Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "172.16.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "prod-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.prod-vpc.id
}

# Custom Route Table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table"
  }
}

# Associating subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table.id
}

# Security Group to allow port 22, 80, 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# Network interface with an ip in the subnet
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["172.10.10.100"]
  security_groups = [aws_security_group.allow_web.id]
}

# Elastic IP to the network interface that was created
resource "aws_eip" "one" {
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.gw]
}

# Installing Ubuntu server and install/enable apache2
resource "aws_instance" "web_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  tags = {
    Name = "tf-example"
  }
}

