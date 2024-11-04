# /*****************************************************************
#  S3 IAM Policies and Roles
# ******************************************************************/

data "aws_iam_policy_document" "s3_webui_policy_doc" {
  statement {
    sid       = "AccessToGetBucketLocation"
    effect    = "Allow"
    actions   = ["s3:GetBucketLocation"]
    resources = ["arn:aws:s3:::*"]
  }

  statement {
    sid    = "AccessToWebsiteBuckets"
    effect = "Allow"
    actions = [
      "s3:PutBucketWebsite",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "AccessToCloudFront"
    effect = "Allow"
    actions = [
      "cloudfront:GetInvalidation",
      "cloudfront:CreateInvalidation"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_webui_policy" {
  name   = "s3-webui-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_webui_policy_doc.json
}

resource "aws_iam_role" "s3_webui_role" {
  name                 = "${local.name_prefix}-${local.env_lowercase}-s3-webui-role"
  description          = "${local.name_prefix}-${local.env_lowercase} S3 Web UI role"
  max_session_duration = 3600
  path                 = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name                         = "${local.name_prefix}-${local.env_lowercase}-lambda-role"
    "blog:technical:environment" = local.env_uppercase
  }
}

resource "aws_iam_role_policy_attachment" "s3_webui_policy_attach" {
  role       = aws_iam_role.s3_webui_role.name
  policy_arn = aws_iam_policy.s3_webui_policy.arn
}