# local_file ?
# - 테라폼의 local 프로바이더로 파일을 프로비저닝하는데 사용된다.
# ${path.module} ?
# - 실행되는 테라폼 모듈의 파일 시스템 경로.

terraform {
  required_version = ">=1.0.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
  }
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

resource "local_file" "abc" {
  content  = "123456!"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = "def!"
  filename = "${path.module}/def.txt"
}