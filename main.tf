terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }


    # backend "remote" {
    #   hostname = "app.terraform.io"
    #   organization = "rudolph.life"
    #   workspaces {
    #     name = "terrahouse"
    #   }
    # }
     cloud {
         organization = "etech-dev"

         workspaces {
           name = "terra-house-1"
         }
       }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_mensa_musa_hosting" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = var.mensa_musa.public_path
  #bucket_name         = var.bucket_name
  content_version     = var.mensa_musa.content_version
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
  domain_name = module.home_mensa_musa_hosting.domain_name
  #domain_name     = "yet637y.cloudfront.net"
  town            = "gamers-grotto"
  content_version = var.mensa_musa.content_version
}




module "home_vacation_hosting" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = var.vacation.public_path
  #bucket_name         = var.bucket_name
  content_version     = var.vacation.content_version
}

resource "terratowns_home" "home_vacation" {
  name        = "Best Vacation Spot in Dubai!!"
  description = <<DESCRIPTION
One of the best vacation spots in Dubai is the Burj Khalifa observation deck. 
It offers breathtaking panoramic views of the city's skyline and beyond, providing a memorable experience for visitors.
DESCRIPTION
  domain_name = module.home_vacation_hosting.domain_name
  #domain_name     = "yet637y.cloudfront.net"
  town            = "the-nomad-pad"
  content_version = var.vacation.content_version

}













