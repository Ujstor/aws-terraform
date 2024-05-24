resource "aws_db_instance" "example" {
  identifier_prefix   = "${var.identifier_prefix}-db"
  engine              = "mysql"
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  skip_final_snapshot = var.skip_final_snapshot
  db_name             = var.db_name

  username = var.db_username
  password = var.db_password
}
