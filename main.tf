terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}



provider "aws" {
  # Configuration options
}


provider "random" {
  # Configuration options
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
  lower            = true
  upper            = false
  numeric          = false
  override_special = ""
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
output "random_bucket_name" {
  value = random_string.bucket_name.result
}





