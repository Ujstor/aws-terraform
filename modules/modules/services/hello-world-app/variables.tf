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

variable "image_id" {
  description = "The ID of the machine image (AMI) to use for the instance"
  type        = string
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

variable "custom_tags" {
  description = "Costum tag to set on the instanc in the ASG"
  default     = {}
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "enable_autoscaling" {
  description = "If set to true enable the Auto Scaling"
  type        = bool
}

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The type of health check to perform. Must be one of: EC2, ELB."
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "The User Data script to run in each Instance at boot"
  type        = string
  default     = null
}
