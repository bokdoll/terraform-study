# local_file ?
# - 테라폼의 local 프로바이더로 파일을 프로비저닝하는데 사용된다.
# ${path.module} ?
# - 실행되는 테라폼 모듈의 파일 시스템 경로.

resource "local_file" "abc" {
  content  = "lifecycle - step 4"
  filename = "${path.module}/abc.txt"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [content]
  }
}

data "local_file" "abc" {
  filename = local_file.abc.filename
}

resource "local_file" "def" {
  depends_on = [local_file.abc]
  content    = data.local_file.abc.filename
  filename   = "${path.module}/def.txt"

  lifecycle {
    prevent_destroy = true
  }
}

# variable "file_name" {
#   default = "step0.txt"
# }

# resource "local_file" "step6" {
#   content  = "lifecycle - step 6"
#   filename = "${path.module}/${var.file_name}"

#   lifecycle {
#     precondition {
#       condition     = var.file_name == "step6.txt"
#       error_message = "file name is not \"step6.txt\""
#     }
#   }
# }

# resource "local_file" "step7" {
#   content  = ""
#   filename = "${path.module}/step7.txt"

#   lifecycle {
#     postcondition {
#       condition     = self.content != ""
#       error_message = "content cannot empty"
#     }
#   }
# }

# output "step7_content" {
#   value = local_file.step7.id
# }

variable "my_pswd" {
  default   = "p4ssw@rd"
  sensitive = true
}

resource "local_file" "ghi" {
  content  = var.my_pswd
  filename = "${path.module}/ghi.txt"
}

variable "my_var" {
  default = "var2"
}

resource "local_file" "jkl" {
  content  = var.my_var
  filename = "${path.module}/variable_priority.txt"
}

variable "prefix" {
  default = "hello"
}

resource "local_file" "mno" {
  content  = local.content
  filename = "${path.module}/locals.txt"
}