variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev/prod)"
  type        = string
}

variable "trusted_admin_ip" {
  description = "Your public IP for VPN/SSH access only"
  type        = string
}

variable "key_name" {
  description = "Existing AWS key pair name"
  type        = string
}

