terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "medium-terraform-remote-state-24"
    key    = "aws/01/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = try(var.environment)
      Project     = "basic-vpc"
    }
  }
}