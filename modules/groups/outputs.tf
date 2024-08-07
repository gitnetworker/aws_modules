output "group_names" {
  value = [for group in aws_iam_group.group : group.name]
}
