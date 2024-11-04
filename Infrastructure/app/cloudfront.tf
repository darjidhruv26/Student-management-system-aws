# /*****************************************************************
#  Amazon CloudFront
# ******************************************************************/

# Public Module Registry:
# https://registry.terraform.io/modules/terraform-aws-modules/cloudfront/aws/latest

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.3"

  comment             = "${local.env_uppercase} CloudFront Distribution for Predictive Maintenance Platform"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  create_origin_access_identity = true

  # All the CloudFront origin access identities made available for this distribution
  origin_access_identities = {
    webui = "Web UI S3 origin"
  }

  # The origin for this distribution
  origin = {
    webui = {
      domain_name = module.webui_bucket.s3_bucket_bucket_regional_domain_name
      origin_id   = local.s3_origin_id

      s3_origin_config = {
        origin_access_identity = "webui"
      }
    }
  }

  # Provide the default cache behaviour for this distribution: HTTP and HTTPS (Default (*))
  default_cache_behavior = {
    target_origin_id           = local.s3_origin_id
    viewer_protocol_policy     = "allow-all"
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  # Provide an ordered list of cache behaviours for this distribution: Redirect HTTP to HTTPS (/*)
  ordered_cache_behavior = [
    {
      path_pattern               = "/*"
      target_origin_id           = local.s3_origin_id
      viewer_protocol_policy     = "redirect-to-https"
      response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]
  
  # This distribution has a dependency on the S3 web UI bucket being created 
  depends_on = [
    module.webui_bucket.s3_bucket_id
  ]
  custom_error_response = [{
    error_code            = 403
    error_caching_min_ttl = 10
    response_code         = 200
    response_page_path    = "/index.html"
  }]

  tags = {
    "blog:technical:environment" = local.env_uppercase
  }
}

# Create a CloudFront response headers policy
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = "security-headers-policy-${local.env_lowercase}"

  custom_headers_config {
    items {
      header   = "permissions-policy"
      override = true
      value    = "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
    }
  }

  security_headers_config {
    content_type_options {
      override = true
    }

    frame_options {
      override     = true
      frame_option = "DENY"
    }

    referrer_policy {
      override        = true
      referrer_policy = "same-origin"
    }

    strict_transport_security {
      override                   = true
      access_control_max_age_sec = 63072000
      include_subdomains         = true
      preload                    = true
    }

    xss_protection {
      override   = true
      mode_block = true
      protection = true
    }
  }
}

###########################
# Origin Access Identities
###########################

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.webui_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
    }
  }
}
