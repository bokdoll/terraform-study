variable "sensitive_content" {
  default   = "S3cr3t"
  sensitive = true
}

resource "local_file" "provisioner_foo1" {
  content  = upper(var.sensitive_content)
  filename = "${path.module}/provisioner-test-output/foo.bar"

  provisioner "local-exec" {
    command = "echo The content is ${self.content}"
  }

  provisioner "local-exec" {
    command    = "abc"
    on_failure = continue
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo The deleting filename is ${self.filename}"
  }
}

resource "null_resource" "provisioner_ex1" {
  provisioner "local-exec" {
    command = <<EOF
    echo Hello!! > file.txt
    echo $ENV >> file.txt
    EOF

    interpreter = ["bash", "-c"]

    working_dir = "/tmp"

    environment = {
      ENV = "world!!"
    }
  }
}

# resource "null_resource" "provisioner_foo2" {

#   # myapp.conf 파일이 /etc/myapp.conf로 업로드 
#   provisioner "file" {
#     source      = "conf/myapp.conf"
#     destination = "/etc/myapp.conf"
#   }

#   # content의 내용이 /tmp/file.log 파일로 생성
#   provisioner "file" {
#     content     = "ami used: ${self.ami}"
#     destination = "/tmp/file.log"
#   }

#   # configs.d 디렉터리가 /etc/configs.d로 업로드
#   provisioner "file" {
#     source      = "conf/configs.d"
#     destination = "/etc"
#   }

#   # apps/app1 디렉터리 내의 파일들만 D:/IIS/webapp1 디레겉리 내에 업로드
#   provisioner "file" {
#     source      = "apps/app1/"
#     destination = "D:/IIS/webapp1"
#   }
# }

# resource "aws_instance" "web" {
#   connection {
#     type     = "ssh"
#     user     = "root"
#     password = var.root_password
#     host     = self.public_ip
#   }

#   provisioner "file" {
#     source      = "script.sh"
#     destination = "/tmp/script.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/script.sh",
#       "/tmp/script.sh args"
#     ]
#   }
# }