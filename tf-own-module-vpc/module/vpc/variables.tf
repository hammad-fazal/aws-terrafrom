variable "vpc_config" {
  description = "To get the CIDR block and VPC name from the user"
  type = object({
    cidr_block = string
    name       = string
  })
}


variable "subnet_config" {
  description = "To get the subnet configuration"
  type = list(object({
    cidr_block = string
    availability_zone = string
    name       = string
  }))
}