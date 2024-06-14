variable "name" {
  description = "The name to use for the EKS cluster"
  type        = string
}

variable "min_size" {
  description = "Minimum number of nodes to have in the EKS cluster"
  type        = number

  validation {
    condition     = var.min_size > 0
    error_message = "ASG can be empty or we'll have an outage!"
  }

  validation {
    condition     = var.max_size <= 10
    error_message = "ASG must have 10 or less instances to keep costs down"
  }
}

variable "max_size" {
  description = "Maximum number of nodes to have in the EKS cluster"
  type        = number
}

variable "desired_size" {
  description = "Desired number of nodes to have in the EKS cluster"
  type        = number
}

variable "instance_types" {
  description = "The types of EC2 instances to run in the node group"
  type        = list(string)

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_types)
    error_message = "Only free tier instances are supported | t2.micro, t3.micro"
  }
}
