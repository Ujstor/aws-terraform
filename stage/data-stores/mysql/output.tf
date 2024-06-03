output "address" {
  description = "The address of the DB instance."
  value       = module.mysql_db_stage.address
}

output "port" {
  description = "The port of the DB instance."
  value       = module.mysql_db_stage.port
}

output "arn" {
  description = "The ARN of the primary database"
  value       = module.mysql_db_stage.arn

}
