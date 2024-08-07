resource "aws_iam_user_group_membership" "membership" {
  for_each = var.memberships
  user     = each.value.user
  groups   = each.value.groups
}

output "memberships" {
  value = aws_iam_group_membership.membership.*.user
}