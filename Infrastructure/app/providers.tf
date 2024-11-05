# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      "blog:technical:environment" = local.env_uppercase
    }
  }
}