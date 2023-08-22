locals {
  name    = "terraform"
  content = "${var.prefix} ${local.name}"
  my_info = {
    age    = 20
    region = "KR"
  }
  my_nums = [1, 2, 3, 4, 5]
}