resource "local_file" "foreach_1" {
  for_each = {
    a = "content a"
    b = "content b"
  }
  content  = each.value
  filename = "${path.module}/loop-test-output/${each.key}.txt"
}

variable "map_names" {
  default = {
    a = "content a"
    # b = "content b"
    c = "content c"
  }
}

resource "local_file" "foreach_2" {
  for_each = var.map_names
  content  = each.value
  filename = "${path.module}/loop-test-output/foreach_2-${each.key}.txt"
}

resource "local_file" "foreach_3" {
  for_each = local_file.foreach_2
  content  = each.value.content
  filename = "${path.module}/loop-test-output/foreach_3-${each.key}.txt"
}

resource "local_file" "foreach_4" {
  for_each = toset(["a", "b", "c"])
  content  = "abc"
  filename = "${path.module}/loop-test-output/foreach_4-${each.key}.txt"
}