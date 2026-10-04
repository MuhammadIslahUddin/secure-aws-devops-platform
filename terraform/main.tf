terraform {
  sources = {
    vpc              = "./modules/vpc"
    security_groups  = "./modules/security_groups"
    ec2              = "./modules/ec2"
    alb              = "./modules/alb"
  }
}

module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id
  environment      = var.environment
  trusted_admin_ip = var.trusted_admin_ip
}

module "ec2" {
  source                  = "./modules/ec2"
  environment             = var.environment
  key_name                = var.key_name
  public_subnet_id        = module.vpc.public_subnets[0]
  private_frontend_subnet_id = module.vpc.private_subnets[0]
  private_backend_subnet_id  = module.vpc.private_subnets[1]
  squid_sg_id             = module.security_groups.squid_sg_id
  frontend_sg_id          = module.security_groups.frontend_sg_id
  backend_sg_id           = module.security_groups.backend_sg_id
  vpn_sg_id               = module.security_groups.vpn_sg_id
  squid_private_ip        = module.ec2.squid_private_ip
}

module "alb" {
  source              = "./modules/alb"
  environment         = var.environment
  alb_sg_id           = module.security_groups.alb_sg_id
  public_subnet_ids   = module.vpc.public_subnets
  vpc_id              = module.vpc.vpc_id
  frontend_instance_id = module.ec2.frontend_instance_id
}
