module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-vpc"
  }

  subnet_config = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-2a"
    name = "public-subnet" },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-2b"
      name              = "private-subnet"
    }

  ]
}
