# Public Module Registry:
# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

# /*****************************************************************
#  S3 Bucket for React UI Application
# ******************************************************************/

# Retrieve the S3 Website Policy document
data "aws_iam_policy_document" "s3_website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${local.webui_bucket_name}/*"
    ]
  }
}

module "webui_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.1.0"

  bucket = local.webui_bucket_name

  # Remove or comment out the ACL setting
  acl = var.acl

  force_destroy = var.force_destroy

  # Set the policy to the S3 website policy document rendered in JSON 
  policy = data.aws_iam_policy_document.s3_website_policy.json

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      id      = "STANDARD_IA"
      enabled = true

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]
    }
  ]

  tags = {
    Name                         = local.webui_bucket_name
    "blog:technical:environment" = local.env_uppercase
  }
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.webui_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}
