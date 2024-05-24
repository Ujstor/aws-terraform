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

variable "identifier_prefix" {
  description = "Prefix for the DB instance identifier"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final snapshot before deleting the instance"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "example_db"
}
