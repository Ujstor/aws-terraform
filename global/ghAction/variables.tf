variable "allowed_repos_branches" {
  description = "GitHub repos/branches allowed to assume the IAM role."
  type = list(object({
    org    = string
    repo   = string
    branch = string
  }))
  default = [
    {
      org    = "ujstor"
      repo   = "aws-asg-tf"
      branch = "master"
    }
  ]
}
