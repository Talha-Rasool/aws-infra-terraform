provider "aws" {
    region = "eu-central-1"
  
}

resource "aws_eip" "nat_eip" {

    count = length(var.private_subnet_ids)
    domain = "vpc"

    tags = {
        Name = "nat_eip ${count.index + 1}"
    }
  
}

resource "aws_nat_gateway" "nat" {
    count = length(var.public_subnet_ids)
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = var.public_subnet_ids[count.index]

    tags = {
      Name = "nat-gateway${count.index + 1}"
    }

    depends_on = [ aws_eip.nat_eip ]

  
}

resource "aws_route_table" "private_rt" {
    count = length(var.private_subnet_ids)
    vpc_id = var.vpc_id
    
     tags = {
       Name = "private-rt-${count.index + 1}"
      }

    route {
       cidr_block     = "0.0.0.0/0"
       nat_gateway_id = aws_nat_gateway.nat[count.index % length(var.public_subnet_ids)].id
    }
  
}
     


resource "aws_route_table_association" "private_assoc" {
    count = length(var.private_subnet_ids)
    subnet_id = var.private_subnet_ids[count.index]
    route_table_id = aws_route_table.private_rt[count.index].id
  
}