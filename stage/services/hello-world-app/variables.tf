variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "stage"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  # default     = "tf-state-ujstor"
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
  # default     = "stage/data-stores/mysql/terraform.tfstate"
}

# variable "mysql_config" {
#   description = "The config for the MySQL DB"
#   type = object({
#     address = string
#     port    = number
#   })
#   default = {
#     address = "mock-mysql-address"
#     port    = 12345
#   }
# }
