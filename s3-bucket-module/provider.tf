terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "hyeonju-tfstate-bucket"
    key            = "state/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "hyeonju-tfstate-table"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}
