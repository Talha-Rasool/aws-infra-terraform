
resource "aws_instance" "bastion" {
  ami           = var.ami_value  # Update with latest Ubuntu AMI
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  security_groups = [var.bastion_sg_id]
  associate_public_ip_address = true
  tags = { Name = "Bastion Host" }

  
}