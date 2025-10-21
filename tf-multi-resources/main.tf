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

locals {
  project = "project-01"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = local.project # name of the VPC is project-01
  }
}

# create 2 subnets in the VPC 
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.${count.index}.0/24" # create 2 subnets with different CIDR blocks
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index + 1}" # create 2 subnets with different names
  }
}

# create 4 EC2 instances and distribute them across the 2 subnets 
resource "aws_instance" "name" {
  instance_type = "t3.micro"
  ami           = "ami-0c55b159cbfafe1f0"
  count         = 4
  subnet_id = aws_subnet.subnet[count.index % length((aws_subnet.subnet))].id # distribute instances across the 2 subnets

  tags = {
    Name = "${local.project}-instance-${count.index + 1}"
  }
}

# create EC2 instances based on the ec2_config variable
resource "aws_instance" "ec2_instance" {
  count = length(var.ec2_config) # create instances based on the length of the ec2_config variable
  instance_type = var.ec2_config[0].instance_type # create instances based on the instance_type in the ec2_config variable
  ami           = var.ec2_config[0].ami
  subnet_id = aws_subnet.subnet[count.index % length((aws_subnet.subnet))].id # distribute instances across the 2 subnets

  tags = {
    Name = "${local.project}-instance-${count.index + 1}"
  }
  
}

# create EC2 instances based on the ec2_map variable
resource "aws_instance" "ec2_instance_map" {
  for_each = var.ec2_map # create instances based on the length of the ec2_map variable
  instance_type = each.value.instance_type # create instances based on the instance_type in the ec2_map variable
  ami           = each.value.ami
 
  subnet_id = element(aws_subnet.subnet[*].id, index(keys(var.ec2_map), each.key) % length((aws_subnet.subnet))) # logic to distribute instances across subnets 

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
  
}

