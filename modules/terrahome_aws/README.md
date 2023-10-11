## Terrahome AWS

```tf
module "home_mensa_musa" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = mensa_musa_path
  #bucket_name         = var.bucket_name
  content_version     = var.content_version
  
}
```



THe public directory expects the following:
- index.html
- error.html
- assets

ALl top level files in assets will be copied, but not any subdirectories.