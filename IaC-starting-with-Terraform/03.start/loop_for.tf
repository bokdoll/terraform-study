resource "local_file" "for_1" {
  content  = jsonencode(var.list_names)
  filename = "${path.module}/loop-test-output/for_1.txt"
}

resource "local_file" "for_2" {
  content  = jsonencode([for s in var.list_names : upper(s)])
  filename = "${path.module}/loop-test-output/for_2.txt"
}

output "A_upper_value" {
  value = [for v in var.list_names : upper(v)]
}

output "B_index_and_value" {
  value = [for i, v in var.list_names : "${i} is ${v}"]
}

output "C_make_object" {
  value = { for v in var.list_names : v => upper(v) }
}

output "D_with_filter" {
  value = [for v in var.list_names : upper(v) if v != "a"]
}

variable "members" {
  type = map(object({
    role = string
  }))
  default = {
    ab = { role = "member", group = "dev" }
    cd = { role = "admin", group = "dev" }
    ef = { role = "member", group = "ops" }
  }
}

output "A_to_tuple" {
  value = [for k, v in var.members : "${k} is ${v.role}"]
}

output "B_get_only_role" {
  value = {
    for name, user in var.members : name => user.role
    if user.role == "admin"
  }
}

output "C_group" {
  value = {
    for name, user in var.members : user.role => name...
  }
}