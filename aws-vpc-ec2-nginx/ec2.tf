resource "aws_instance" "nginx_server" {
  ami           = "ami-077b630ef539aa0b5"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  user_data     = <<-EOF
              #!/bin/bash
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "<h1>Welcome to NGINX Server</h1>" | sudo tee /usr/share/nginx/html/index.html
              EOF

  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "nginx-server"
  }

}
