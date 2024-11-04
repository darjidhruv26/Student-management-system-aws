# S3 bucket outputs
output "webui_bucket_id" {
  description = "The name of the bucket"
  value       = module.webui_bucket.s3_bucket_id
}

output "webui_bucket_arn" {
  description = "The ARN of the bucket"
  value       = module.webui_bucket.s3_bucket_arn
}

output "webui_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.webui_bucket.s3_bucket_bucket_domain_name
}

output "webui_bucket_name" {
  description = "The name of the bucket"
  value       = module.webui_bucket.s3_bucket_id
}

# CloudFront distribution outputs
output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution"
  value       = module.cloudfront.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to"
  value       = module.cloudfront.cloudfront_distribution_hosted_zone_id
}

output "cloudfront_distribution_id" {
  description = "The identifier for the distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_last_modified_time" {
  description = "The date and time the distribution was last modified"
  value       = module.cloudfront.cloudfront_distribution_last_modified_time
}

output "cloudfront_origin_access_identities" {
  description = "The date and time the distribution was last modified"
  value       = module.cloudfront.cloudfront_origin_access_identities
}