# Configure the AWS Provider
provider "aws" {
  region                   = "ap-south-1"
  shared_credentials_files = ["~/.aws/credentials"] # path to AWS credentials file
  profile                  = "Dhruv@Dev"            # profile name in credentials file

  default_tags {
    tags = {
      "blog:technical:environment" = local.env_uppercase
    }
  }
}