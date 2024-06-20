module "mysql_db_stage" {
  # source = "github.com/ujstor/aws-terraform//modules/modules/data-stores/mysql?ref=v0.1.3"
  source = "../../../modules/modules/data-stores/mysql"

  providers = {
    aws = aws.stage
  }

  identifier_prefix = "stage-mysql"
  instance_class    = "db.t3.micro"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

