terraform {
  backend "s3" {
    bucket         = "tf-state-ujstor"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "stage"

  # assume_role {
  #   role_arn = "arn:aws:iam::891377095143:role/OrganizationAccountAccessRole"
  # }

  default_tags {
    tags = {
      Owner     = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

