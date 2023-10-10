terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }


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
}

provider "terratowns" {
  endpoint  = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source              = "./modules/terrahouse_aws"
#   user_uuid           = var.user_uuid
#   bucket_name         = var.bucket_name
#   index_html_filepath = var.index_html_path
#   error_html_filepath = var.error_html_path
#   content_version     = var.content_version
# }

resource "terratowns_home" "home" {
  name        = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Mansa Musa, also known as Musa I of Mali, was a 14th-century 
West African ruler who is often regarded as one of the wealthiest individuals in history. 
He achieved this status due to his empire's vast reserves of gold and salt, which were 
pivotal in the global trade network at the time. His pilgrimage to Mecca in 1324, 
accompanied by a vast retinue and tons of gold, is famous for contributing to the economic 
instability of regions along his route due to the sheer scale of his wealth.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name     = "673yg847uh.cloudfront.net"
  town            = "gamers-grotto"
  content_version = 1
}













