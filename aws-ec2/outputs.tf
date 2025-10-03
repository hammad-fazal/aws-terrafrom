output "aws_server_public_ip" {
  description = "The public IP address of the AWS EC2 instance"
  value       = aws_instance.mysever.public_ip
  
}