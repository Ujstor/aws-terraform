module "mysql_primary" {
  source = "github.com/ujstor/aws-terraform//modules/modules/data-stores/mysql?ref=v0.1.3"
  # source = "../../../modules/modules/data-stores/mysql/"

  providers = {
    aws = aws.primary
  }

  identifier_prefix = "prod-mysql"
  instance_class    = "db.t3.micro"
  db_name           = "prodDB"

  db_username = var.db_username
  db_password = var.db_password

  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  identifier_prefix   = "prod-mysql"
  replicate_source_db = module.mysql_primary.arn
}

