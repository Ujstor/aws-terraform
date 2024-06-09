variable "tf_remote_state_region" {
  description = "The region to use for the remote state bucket"
  type        = string
  default     = "us-east-1"
}

variable "db_remote_state_bucket" {
  description = "The name of S3 bucked for db remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "Path for the db remote state in S3"
  type        = string
}

variable "server_text" {
  description = "Text the web server should return"
  type        = string
  default     = "Hello World"
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
}
