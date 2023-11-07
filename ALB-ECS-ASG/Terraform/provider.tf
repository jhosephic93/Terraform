terraform {
  required_providers {
    aws = {
      source                        = "hashicorp/aws"
      version                       = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile                           = "jhoseph"
  region                            = "us-east-1"
  shared_credentials_files          = [
    "/Users/mingacah/.aws/credentials"
   ]
}

# Save Terraform State on Bucket S3
terraform {
  backend "s3" {
    bucket                          = "mybucket-terraform-jhoseph-new-account"
    key                             = "./terraform.tfstate"
    region                          = "us-east-1"  # Actualiza con la región adecuada
    profile                         = "jhoseph"
    shared_credentials_file         = "/Users/mingacah/.aws/credentials"
  }
}