
output "file_id" {
  value = local_file.abc.id
}

output "file_abspath" {
  value = abspath(local_file.abc.filename)
}