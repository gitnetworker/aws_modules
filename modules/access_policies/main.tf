resource "aws_iam_policy" "policy" {
  for_each = var.policies
  name     = each.key
  policy   = each.value.policy
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each   = var.policies
  group      = each.value.group
  policy_arn = aws_iam_policy.policy[each.key].arn
}

output "policy_arns" {
  value = [for policy in aws_iam_policy.policy : policy.arn]
}


