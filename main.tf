# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "rudolph.life"
#     workspaces {
#       name = "terrahouse"
#     }
#   }
#    cloud {
#       organization = "etech-dev"

#       workspaces {
#         name = "terra-house-1"
#       }
#     }
# }

module "terrahouse_aws" {
  source      = "./modules/terrahouse_aws"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_path
  error_html_filepath = var.error_html_path
}










