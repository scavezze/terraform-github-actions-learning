terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "nscavezze-terraform-s3-state"
    key    = "my-terraform-project"
    region = "us-west-2"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  region     = "us-east-1"
  alias      = "use1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  mime_types = jsondecode(file("${path.module}/mime.json"))
  domain     = "www.nscavezze.dns-dynamic.net"
}

data "aws_iam_policy_document" "s3_website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}
