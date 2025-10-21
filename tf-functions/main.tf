terraform {}

locals {
  value = "hello world"
}

variable "string_list" {
  type = list(string)
  default = ["serv1", "serv2", "serv3"]
}

output "name" {
  #value = upper(local.value)
  #value = startswith(local.value, "hello")
  value = jsondecode(jsonencode(var.string_list))
}