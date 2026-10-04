resource "aws_lb" "main" {
  name               = "app-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = { Name = "main-alb-${var.environment}" }
}

resource "aws_lb_target_group" "frontend" {
  name     = "frontend-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "frontend" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = var.frontend_instance_id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

variable "environment" {}
variable "alb_sg_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "vpc_id" {}
variable "frontend_instance_id" {}

output "alb_dns_name" { value = aws_lb.main.dns_name }
