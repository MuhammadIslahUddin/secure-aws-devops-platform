# 🔐 Secure Multi-Tier AWS Platform — DevOps Portfolio

## Overview
Production-grade AWS architecture demonstrating defense-in-depth security, IaC, and automated CI/CD.

## Architecture
- **Public Edge**: ALB — single entry point, port 80 only
- **Outbound Gateway**: Squid Proxy (8888) — centralized logging/control
- **Private Tier**: Frontend + Backend — **no public IPs**
- **Admin Access**: OpenVPN only — zero public SSH exposure
- **Automation**: Terraform modules + GitHub Actions pipeline

## Tech Stack
AWS · Terraform · Docker · GitHub Actions · Squid · OpenVPN · Nginx · Flask

## Quick Start
```bash
# Update your IP
curl -s ifconfig.me
# → Paste into terraform/environments/dev/terraform.tfvars

# Deploy
cd terraform/environments/dev
terraform init
terraform plan
terraform apply

Author
Built by Muhammad Islah Uddin— DevOps Engineer
plaintext

---

# 🎯 Next Steps to Complete
1. **Get your public IP**:
   ```bash
   curl -s ifconfig.me
