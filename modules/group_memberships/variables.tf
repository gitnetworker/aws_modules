variable "memberships" {
  type        = map(any)
  description = "A map of group memberships to create"
}

variable "user_names" {
  type        = list(string)
  description = "A list of user names"
}

variable "group_names" {
  type        = list(string)
  description = "A list of group names"
}
