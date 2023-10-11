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
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  #bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_path
  error_html_filepath = var.error_html_path
  content_version     = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name        = "The Richest Man in History!"
  description = <<DESCRIPTION
Mansa Musa, also known as Musa I of Mali, was a 14th-century 
West African ruler who is often regarded as one of the wealthiest individuals in history. 
He achieved this status due to his empire's vast reserves of gold and salt, which were 
pivotal in the global trade network at the time. His pilgrimage to Mecca in 1324, 
accompanied by a vast retinue and tons of gold, is famous for contributing to the economic 
instability of regions along his route due to the sheer scale of his wealth.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name     = "yet637y.cloudfront.net"
  town            = "missingo"
  content_version = 1
}













