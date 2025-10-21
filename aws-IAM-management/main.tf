terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = "us-east-2" # in variables.tf file
}


# create IAM users 
resource "aws_iam_user" "main" {
  for_each = toset(local.users[*].username)
  name     = each.value
}

# create login profiles for IAM users with temporary passwords
resource "aws_iam_user_login_profile" "example" {
  for_each                = aws_iam_user.main
  user                    = each.value.name
  password_length         = 12
  password_reset_required = true


  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

# Attach managed policies to users
resource "aws_iam_user_policy_attachment" "attachments" {
  for_each = { for idx, att in local.attachments : "${att.user}-${idx}" => att }

  user       = aws_iam_user.main[each.value.user].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.permission}"
}

output "iam_users" {
  value = { for k, u in aws_iam_user.main : k => u.name }
}


