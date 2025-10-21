# create a variable for AWS instance type with validation
variable "aws_instance_type" {
  description = "Type of AWS EC2 instance"
  type        = string
  validation {
    condition     = var.aws_instance_type == "t3.micro" || var.aws_instance_type == "t2.micro"
    error_message = "Instance type must be either 't3.micro' or 't2.micro'"
  }
}

# create variable for EC2 root block device configuration
variable "ec2_config" {
  type = object({
    v_type = string
    v_size = number
  })
  default = {
    v_type = "gp2"
    v_size = 20
  }
}

# create variable for tags
variable "additional_tags" {
  description = "Additional tags to add to resources"
  type        = map(string)
  default     = {}
  
}