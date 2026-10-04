variable "vpc_id" {}
variable "environment" {}
variable "trusted_admin_ip" {}

resource "aws_security_group" "main" {
  name        = "main-sg-${var.environment}"
  description = "Allow HTTP, API, SSH from trusted IP"
  vpc_id      = var.vpc_id

  # Portfolio Website
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Backend API
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH — sirf aapke liye
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.trusted_admin_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "main-sg-${var.environment}" }
}

output "main_sg_id" {
  value = aws_security_group.main.id
}
