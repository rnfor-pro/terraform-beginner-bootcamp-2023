output "bucket_name" {
  description = "S3 static website hosting endpoint"
  value       = module.home_mensa_musa_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "Bucket name for our static website hosting"
  value       = module.home_mensa_musa_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "TheCloudfront Destribution Domain Name"
  value       = module.home_mensa_musa_hosting.domain_name
}