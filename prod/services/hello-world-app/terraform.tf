terraform {
  backend "s3" {
    bucket         = "tf-state-ujstor"
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0, < 2.0.0"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner     = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

