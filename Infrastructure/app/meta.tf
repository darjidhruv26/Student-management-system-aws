terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
  }
}

# Get access to the effective Account ID, User ID, and ARN in which Terraform is authorised
data "aws_caller_identity" "current" {
}

# Get the current AWS region
data "aws_region" "current" {
}


locals {
  name_prefix          = lower(var.name_prefix)
  webui_bucket_name    = "blog-${var.team_abbrv}-${var.purpose}-webui-${local.env_lowercase}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  s3_origin_id = "blog-${local.env_lowercase}"

  env_lowercase = lower(var.env)
  env_uppercase = upper(var.env)
}