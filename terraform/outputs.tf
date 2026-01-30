# =============================================================================
# Terraform Outputs
# =============================================================================

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "private_key_path" {
  description = "Path to the private key for SSH access"
  value       = local_file.private_key.filename
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app.public_dns
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${local_file.private_key.filename} ec2-user@${aws_instance.app.public_ip}"
}

output "app_url" {
  description = "Application URL"
  value       = "http://${aws_instance.app.public_ip}"
}
