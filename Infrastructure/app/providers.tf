# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  # shared_credentials_files = ["~/.aws/credentials"] 
  profile                  = "Dhruv@Dev"            

  default_tags {
    tags = {
      "blog:technical:environment" = local.env_uppercase
    }
  }
}