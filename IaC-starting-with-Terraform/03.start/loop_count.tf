resource "local_file" "count_1" {
  count    = 3
  content  = "abc"
  filename = "${path.module}/loop-test-output/count_1_${count.index}.txt"
}

variable "list_names" {
  type    = list(string)
  default = ["a", "b"]
}

resource "local_file" "count_2" {
  count   = length(var.list_names)
  content = "abc"
  # 변수 인덱스에 직접 접근
  filename = "${path.module}/loop-test-output/count_2-${var.list_names[count.index]}.txt"
}

resource "local_file" "count_3" {
  count   = length(var.list_names)
  content = local_file.count_2[count.index].content
  # element function 활용
  filename = "${path.module}/loop-test-output/count_3-${element(var.list_names, count.index)}.txt"
}