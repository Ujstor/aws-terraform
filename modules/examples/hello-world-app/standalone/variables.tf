variable "mysql_config" {
  description = "The config for the MySQL DB"
  type = object({
    address = string
    port    = number
  })
  default = {
    address = "mock-mysql-address"
    port    = 12345
  }
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy into"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "The IDs of the subnets to deploy into"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "snadbox-hello-world-example"
}
