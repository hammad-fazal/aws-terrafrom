terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = var.region  # in variables.tf file
}

resource "aws_instance" "mysever" {
  ami           = "ami-077b630ef539aa0b5"
  instance_type = "t3.micro"

  tags = {
    Name = "MyFirstTerraformServer"
  }
  
}