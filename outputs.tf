output "bucket_name" {
  description = "S3 static website hosting endpoint"
  value       = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "Bucket name for our static website hosting"
  value       = module.terrahouse_aws.website_endpoint
}