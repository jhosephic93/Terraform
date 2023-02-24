terraform {
  required_providers {
    aws = {
      source      = "hashicorp/aws"
      version     = "4.55.0"
    }
    kubernetes = {
      source      = "hashicorp/kubernetes"
      version     = "2.18.0"
    }
    tls = {
      source      = "hashicorp/tls"
      version     = "4.0.4"
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

provider "kubernetes" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}