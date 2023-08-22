variable "abc_map" {
  default = {
    a = "hello a"
    b = "hello b"
    c = "hello c"
  }
}

data "archive_file" "dotfiles" {
  type        = "zip"
  output_path = "${path.module}/loop-test-output/dotfiles.zip"

  dynamic "source" {
    for_each = var.abc_map

    content {
      content  = source.value
      filename = "${path.module}/loop-test-output/dynamic_${source.key}.txt"
    }
  }

  # source {
  #   content  = "hello a"
  #   filename = "${path.module}/loop-test-output/dynamic_a.txt"
  # }

  # source {
  #   content  = "hello b"
  #   filename = "${path.module}/loop-test-output/dynamic_b.txt"
  # }

  # source {
  #   content  = "hello c"
  #   filename = "${path.module}/loop-test-output/dynamic_c.txt"
  # }
}
