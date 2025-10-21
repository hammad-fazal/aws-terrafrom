terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }

  backend "s3" {
    bucket         = "mydemobucket-f96149d66819c6e0"  # use the bucket created in aws-s3/main.tf
    key            = "backend.tfstate" # path within the bucket to store the state file
    region         = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"  # in variables.tf file
}

resource "aws_instance" "mysever" {
  ami           = "ami-077b630ef539aa0b5"
  instance_type = "t3.micro"

  tags = {
    Name = "Backend-server-demo"
  }
  
}