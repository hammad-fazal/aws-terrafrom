locals {
  users_yaml = yamldecode(file("${path.module}/users.yml"))
  users       = lookup(local.users_yaml, "users", [])

  # Normalize permissions: if permission is a string -> split returns a single-item list; if it's already a list, try(...) returns it
  normalized = { for u in local.users : u.username => {
    username    = u.username
    permissions = try(split(",", u.permission), u.permission)
  }}

  # Flatten into a list of { user, permission } objects for attachments
  attachments = flatten([
    for uname, data in local.normalized : [
      for perm in data.permissions : {
        user       = uname
        permission = trimspace(perm)
      }
    ]
  ])
}


