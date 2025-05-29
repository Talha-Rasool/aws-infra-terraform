provider "aws" {
    region = "eu-central-1"
  
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = { 
    Name = "mernvpc" 
    }
}



# Subnets


resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    count = length(var.public_subnet_cidr)
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.avz[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-eu-central-${count.index + 1}"
    }

  
}


resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.avz[count.index]

    tags = {
        Name = "private-eu-central-${count.index + 1}"
    }
  
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
  
}

resource "aws_route_table" "public_rt" {
    #count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    
    
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id

    }

    tags = {
        Name = "public-rt"
    }


}

resource "aws_route_table_association" "public_assoc" {
    count = length(aws_subnet.public)

    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public_rt.id
    #route_table_id = aws_route_table.public_rt[count.index].id
  
}