terraform {
  backend "s3" {
    profile = "realpha-staging"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.61.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      "Owner" : "ReAlpha"
      "Manager" : "Terraform"
    }
  }
  profile = "realpha-staging"
}
