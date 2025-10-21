# create a variable to hold EC2 instance configurations with 2 objects
# It also sets how many times the aws_instance.ec2_instance resource will be created
# Each object contains the instance_type and ami for the EC2 instance
ec2_config = [{
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  }, {
  ami           = "ami-0cfde0ea8edd312d4"
  instance_type = "t3.micro"
}]

# create a variable to hold EC2 instance configurations with a map of objects for better flexibility
# Here, the keys are "ubuntu" and "amazon-linux" and the values are objects containing the instance_type and ami for the EC2 instance
ec2_map = {
  "ubuntu" = {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t3.micro"
  }
  amazon-linux = {
    ami           = "ami-0cfde0ea8edd312d4"
    instance_type = "t3.micro"
  }
}
