module "mysql_db_stage" {
  source = "../../../modules/modules/data-stores/mysql"

  providers = {
    aws = aws.stage
  }

  identifier_prefix = "stage-mysql"
  instance_class    = "db.t3.micro"
  db_name           = "stageDB"

  db_username = var.db_username
  db_password = var.db_password
}

