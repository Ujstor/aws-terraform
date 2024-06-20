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

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "stageDb"
}
