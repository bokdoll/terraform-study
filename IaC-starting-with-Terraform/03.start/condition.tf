variable "enable_file" {
  default = true
}

resource "local_file" "condition_1" {
  count    = var.enable_file ? 1 : 0
  content  = "foo!"
  filename = "${path.module}/condition-test-output/foo.bar"
}

output "condition_content" {
  value = var.enable_file ? local_file.condition_1[0].content : ""
}