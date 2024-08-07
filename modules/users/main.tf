resource "aws_iam_user" "user" {
  for_each = var.users
  name     = each.key
}

output "user_names" {
  value = aws_iam_user.user.*.name
}