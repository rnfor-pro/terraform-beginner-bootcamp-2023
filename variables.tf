variable "terratowns_access_token" {
  type = string
}


variable "teacherseat_user_uuid" {
  type = string
}

variable "mensa_musa" {
   type = object({
   public_path = string
   content_version = number
})
}

variable "vacation" {
   type = object({
   public_path = string
   content_version = number
})
}

# variable "bucket_name" {
#   type = string
# }

# variable "mensa_musa_public_path" {
#   type = string
# }

# variable "vacation_public_path" {
#   type = string
# }




# variable "index_html_path" {
#   type = string
# }

# variable "error_html_path" {
#   type = string
# }

# variable "mensa_musa_content_version" {
#   type = number
# }

# variable "assets_path" {
#   type = string
# }

variable "terratowns_endpoint" {
  type = string
}

