resource "aws_db_instance" "example" {
  identifier_prefix   = "${var.identifier_prefix}-db"
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  skip_final_snapshot = var.skip_final_snapshot

  # Enable backups
  backup_retention_period = var.backup_retention_period
  # If specified, this DB will be a replica
  replicate_source_db = var.replicate_source_db

  engine   = var.replicate_source_db == null ? "mysql" : null
  db_name  = var.replicate_source_db == null ? var.db_name : null
  username = var.replicate_source_db == null ? var.db_username : null
  password = var.replicate_source_db == null ? var.db_password : null
}
