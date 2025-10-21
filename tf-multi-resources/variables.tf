# create a variable to hold EC2 instance configurations
variable "ec2_config" {
  type = list(object({
    instance_type = string
    ami           = string
  }))
}

# create a variable to hold EC2 instance configurations with a map of objects for better flexibility
variable "ec2_map" {
  type = map(object({
    instance_type = string
    ami           = string
  }))
}