#create security group to allow HTTP and SSH traffic
resource "aws_security_group" "my_sg" {
  description = "Allow HTTP and ssh traffic"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    from_port   = 80 # allow HTTP traffic on port 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access from anywhere (for demo; restrict in production)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 # allow all outbound traffic
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
   name = "my_sg"
  }
}
