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

resource "aws_instance" "my_instance" {
  ami           = "ami-077b630ef539aa0b5"
  instance_type = var.aws_instance_type
  root_block_device {
    volume_type = var.ec2_config.v_type
    volume_size = var.ec2_config.v_size
  }

  tags = merge(
    {
      Name = "My-EC2-Instance"
    },
    var.additional_tags
  )
  
}