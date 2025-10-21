terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = "us-east-2" # in variables.tf file
}

# fetch the latest Amazon Linux 2 AMI
data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"] # Amazon
}

output "name" {
  value = data.aws_ami.name.id
}

# fetch the subnet by its tags
data "aws_subnet" "name" {
  tags = {
    Name = "private-subnet"
    ENV  = "PROD"
  }
}


output "subnet" {
  value = data.aws_subnet.name.id
  
}

# fetch the security group by its tags
data "aws_security_group" "name" {
  tags = {
    Name = "mySG"
  }
}

output "sg" {
  value = data.aws_security_group.name.id
}

# Create an EC2 instance using the AMI, subnet, and security group fetched via data sources
resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.name.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.name.id]
  subnet_id = data.aws_subnet.name.id

  tags = {
    Name = "Data-source-example"
  }

}
