resource "aws_vpc" "terraform-vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "terraform-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true # This is important for the instances in the public subnet to have a public IP
    tags = {
      Name = "terrraform-public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = "ap-south-1b"
    tags = {
      Name = "terrraform-private_subnet"
    }
  
}

resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      Name = "terraform-igw"
    }
  
}

resource "aws_route_table" "terraform-public_route_table" {
    vpc_id = aws_vpc.terraform-vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
      Name = "terraform-public-rt"
    }
}

resource "aws_route_table" "terraform-private_route_table" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      Name = "terraform-private-rt"
    }
  
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.terraform-public_route_table.id
  
}

resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.terraform-private_route_table.id
  
}

  
