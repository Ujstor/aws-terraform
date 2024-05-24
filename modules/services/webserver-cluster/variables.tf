variable "tf_remote_state_region" {
  description = "The region to use for the remote state bucket"
  type        = string
  default     = "us-east-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of S3 bucked for db remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "Path for the db remote state in S3"
  type        = string
}

variable "image_id" {
  description = "The ID of the machine image (AMI) to use for the instance"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
}
