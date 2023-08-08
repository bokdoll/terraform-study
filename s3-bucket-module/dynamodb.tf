# https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "hyeonju-tfstate-table"
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}