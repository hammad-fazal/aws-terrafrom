# create a tfvars file to define variables used in main.tf file of tf-variables module
aws_instance_type = "t3.micro"
ec2_config = {
  v_type = "gp3"
  v_size = 30
}
additional_tags = {
  Environment = "Dev"
  Project     = "Terraform"
}
