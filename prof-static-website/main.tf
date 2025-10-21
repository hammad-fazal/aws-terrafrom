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
resource "aws_s3_bucket" "mywebapp-bucket" {
  bucket = "mywebapp-bucket-${random_id.rand_id.hex}"  # bucket name must be globally unique
}

# Enable public access for the bucket
resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# To set the bucket policy to allow public read access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.mywebapp-bucket.arn}/*"
      }
    ]
  })
}

# To configure the bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  index_document {
    suffix = "index.html"
  }
}

# To upload a file to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.mywebapp-bucket.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
  etag   = filemd5("index.html")
  
}

resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.mywebapp-bucket.bucket
  key    = "style.css"
  source = "./style.css"
  content_type = "text/css"
  etag   = filemd5("style.css")
  
}

output "mywebapp_link" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}


