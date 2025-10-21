terraform {}

# create a variable of type list of numbers
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

# create a variable of type list of objects 
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [{
    fname = "shakir"
    lname = "ali"
    }, {
    fname = "sabir"
    lname = "khan"
  }]
}

# create a variable of type map of numbers
variable "numbers" {
  type    = map(number)
  default = { one = 1, two = 2, three = 3 }
}

# create locals to manipulate the above variables
locals {
  add    = 2 + 2
  double = [for n in var.num_list : n * 2]
  odd    = [for num in var.num_list : num if num % 2 != 0]

  # create a new list with only first names from person_list
  persons_fname = [for p in var.person_list: p.fname]

  # create a new list with values doubled
  map_values   = [for key, value in var.numbers : value * 2]

  # create a new map with values tripled for odd values only
  new_map = {for k,v in var.numbers : k => v * 3 if v % 2 != 0}
}

output "output" {
  value = local.new_map
}

