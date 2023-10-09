module "vpc" {
    source = "./modules/aws_vpc"
    vpc_cidr = var.vpc_cidr
    vpc_tag = var.vpc_tag
}

module "subnet" {
    source = "./modules/aws_subnet"
    vpcId = module.vpc.vpc_id_val           
    subnet_cidr = var.subnet_cidr
    subnet_tag = var.subnet_tag
}

module "sg" {
    source = "./modules/aws_sg"
    vpc_id = module.vpc.vpc_id_val
    sg_name = var.sg_name
}

module "route_table" {
    source = "./modules/aws_route_table"
    gw_id = module.igw.aws_internet_gateway
    vpc_id = module.vpc.vpc_id_val
    subnet_id = module.subnet.subnet_id
}

module "nic" {
    source = "./modules/aws_nic"
    subnet_id = module.subnet.subnet_id
    private_ips = var.private_ips
    associate_private_ips = var.associate_private_ips
}

module "igw" {
    source = "./modules/aws_igw"
    vpc_id = module.vpc.vpc_id_val
}

module "ec2" {
    source = "./modules/aws_ec2"
    instance_ami = var.instance_ami
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    nic_id = module.nic.nic_id
    instance_tag = var.instance_tag
}