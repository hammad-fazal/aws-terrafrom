output "nginx_public_ip" {
   value = aws_instance.nginx_server.public_ip
   description = "The public IP address of the NGINX server instance"
}  

output "public_url" {
  value = "http://${aws_instance.nginx_server.public_ip}"
  description = "The public URL to access the NGINX server"
  
}