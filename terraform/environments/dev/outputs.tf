output "server_public_ip" {
  value = module.ec2.public_ip
  description = "Apne browser mein yeh IP open karein"
}
