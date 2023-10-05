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