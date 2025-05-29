variable "subnet_id" {
  description = "Subnet ID where bastion host will be deployed"
  type        = string
}

variable "bastion_sg_id" {
    description = "security group ID of bastion-sg"
    type = string
  
}

variable "ami_value" {
    type = string
    default = "ami-03250b0e01c28d196"
  
}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
  type = string
}