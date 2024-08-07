resource "aws_iam_group" "group" {
  for_each = var.groups
  name     = each.key
}
