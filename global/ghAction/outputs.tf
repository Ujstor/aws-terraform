output "aws_iam_github_actions_oidc_arn" {
  description = "The ARN of the IAM OIDC identity provider for GitHub Actions"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}

output "aws_iam_github_actions_oidc_url" {
  description = "The URL of the IAM OIDC identity provider for GitHub Actions"
  value       = aws_iam_openid_connect_provider.github_actions.url
}

output "github_actions_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions"
  value       = aws_iam_role.github_actions_role.arn
}
