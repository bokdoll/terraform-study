# local_file ?
# - 테라폼의 local 프로바이더로 파일을 프로비저닝하는데 사용된다.
# ${path.module} ?
# - 실행되는 테라폼 모듈의 파일 시스템 경로.

resource "local_file" "abc" {
  content  = "abc!"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = "def!"
  filename = "${path.module}/def.txt"
}