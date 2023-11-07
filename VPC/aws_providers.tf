terraform {
  required_providers {
    aws = {
      source      = "hashicorp/aws"
      version     = "4.55.0"
    }
  }
}

provider "aws" {
  # Configuration options
   profile                  = "jhoseph"
   region                   = var.AWS_REGION
   shared_credentials_files = [
    "/Users/mingacah/.aws/credentials"
   ]
}