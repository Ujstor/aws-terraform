terraform {
  backend "s3" {
    bucket         = "tf-state-ujstor"
    key            = "prod/data-stores/mysql/terraform.tfstate"
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
  default_tags {
    tags = {
      Owner     = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

module "mysql-db" {
  source = "../../../modules/data-stores/mysql"

  identifier_prefix = "prod-mysql-db"
  instance_class    = "db.t3.micro"
  db_name           = "prodDB"

  db_username = var.db_username
  db_password = var.db_password
}

variable "db_username" {
  description = "Username to use to connect to the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password to use to connect to the database"
  type        = string
  sensitive   = true
}

output "address" {
  description = "The address of the DB instance."
  value       = module.mysql-db.address
}

output "port" {
  description = "The port of the DB instance."
  value       = module.mysql-db.port
}
