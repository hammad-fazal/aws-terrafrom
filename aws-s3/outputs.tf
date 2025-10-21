output "name_of_s3_bucket" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.tf-bucket.bucket
  
}