variable "user_names" {
  description = "List of users to be added to the user"
  type        = "list(string)"
  default     = ["neo", "trinity", "morpheus"]
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

variable "give_neo_cloudwatch_full_access" {
  description = "If true, Neo gets full access to CloudWatch"
  type        = bool
}
