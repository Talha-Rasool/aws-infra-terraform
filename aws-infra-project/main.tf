provider "aws" {
    region = "eu-central-1"
  
}

module "vpc" {
    source                = "./modules/vpc"
    vpc_cidr              = "10.0.0.0/16"
    avz                   = ["eu-central-1a", "eu-central-1b"]
    public_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidr   = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "keypair" {
    source = "./modules/keypairs"
    key_name = "your-key-name"
    public_key_path = "your-public-key-path"
  
}

module "nat" {
    source                = "./modules/natGateway"
    public_subnet_ids = module.vpc.public_subnet_ids
    private_subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
  
}

module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.vpc.vpc_id
  
}



module "alb" {
  source              = "./modules/alb"
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  alb_sg_id           = module.security_groups.alb_sg_id
  tg_frontend_port    = 3000
  tg_backend_port     = 5001
  frontend_path       = "api path for frontend"
  backend_path        = "api path for backend"
  backend_health_path = "health check path"
}

module "bastion" {
  source         = "./modules/bastion-host"
  key_name = module.keypair.key_name
  subnet_id      = module.vpc.public_subnet_ids[0]
  bastion_sg_id  = module.security_groups.bastion_sg_id
}

module "autoscaling" {
  source               = "./modules/autoScaling-group"
  key_name = module.keypair.key_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  app_sg_id            = module.security_groups.app_sg_id
  tg_frontend_arn      = module.alb.tg_frontend_arn
  tg_backend_arn       = module.alb.tg_backend_arn
  launch_template_name = "my-launch-template" # Replace with your actual launch template name
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "bastion_public_ip" {
    value = module.bastion.bastion_public_ip
  
}
