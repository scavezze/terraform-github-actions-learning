terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket     = "nscavezze-terraform-s3-state"
    key        = "my-terraform-project"
    region     = "us-west-2"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
