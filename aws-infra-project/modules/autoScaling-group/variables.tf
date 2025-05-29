variable "launch_template_name" {}

variable "ami_value" {
    default = "ami-03250b0e01c28d196"
  
}

variable "instance_type" {
    default = "t2.medium"
  
}

variable "app_sg_id" {
  
}

variable "private_subnet_ids" {
    type = list(string)
  
}

variable "tg_frontend_arn" {
  
}

variable "tg_backend_arn" {
  
}

variable "key_name" {
    type = string
  
}