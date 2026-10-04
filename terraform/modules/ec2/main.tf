variable "subnet_id" {}
variable "security_group_id" {}
variable "key_name" {}
variable "environment" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro" # ✅ Free Tier Eligible
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-SCRIPT
#!/bin/bash
apt update -y
apt install -y docker.io docker-compose
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
SCRIPT
  )

  tags = {
    Name        = "app-server-${var.environment}"
    Environment = var.environment
  }
}

output "public_ip" {
  value = aws_instance.app.public_ip
}
output "private_ip" {
  value = aws_instance.app.private_ip
}
output "instance_id" {
  value = aws_instance.app.id
}
