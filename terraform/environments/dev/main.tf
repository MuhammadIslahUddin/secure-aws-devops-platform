terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "../../modules/vpc"
}

module "security_groups" {
  source            = "../../modules/security_groups"
  vpc_id            = module.vpc.vpc_id
  environment       = var.environment
  trusted_admin_ip  = var.trusted_admin_ip
}

module "ec2" {
  source            = "../../modules/ec2"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_groups.main_sg_id
  key_name          = var.key_name
  environment       = var.environment
}
