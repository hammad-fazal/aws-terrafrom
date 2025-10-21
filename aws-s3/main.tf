terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region = "us-east-2"  # in variables.tf file
}

# to generate a random id for making the bucket name unique
resource "random_id" "rand_id" {
  byte_length = 8
}

# To create an S3 bucket
resource "aws_s3_bucket" "tf-bucket" {
  bucket = "mydemobucket-${random_id.rand_id.hex}"  # bucket name must be globally unique
}

# To upload a file to the S3 bucket
resource "aws_s3_object" "my_file" {
  bucket = aws_s3_bucket.tf-bucket.bucket
  key    = "my_file.txt"
  source = "my_data.txt"
  etag   = filemd5("my_data.txt")
  
}
