output "all_arns" {
  description = "List of all ARNs"
  value       = values(aws_iam_user.example)[*].arn
}

output "uper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "short_uper_names" {
  value = [for name in var.user_names : upper(name) if lenght(name0 < 5)]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "uper_roles_map" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = "%{for name in var.user_names}${name}, %{endfor}"

  # output = for_directive = "neo, trinity, morpheus,
}

output "for_directive_index" {
  value = join(", ", [for i, name in var.user_names : "(${i}) ${name}"])

  # outputs: for_directive_index = "(0) neo, (1) trinity, (2) morpheus,
}


output "neo_cloudwatch_policy_arn" {
  value = (
    var.give_neo_cloudwatch_full_access
    ? aws_iam_user_policy_attachment.neo_cloudwatch_full_access[0].policy_arn
    : aws_iam_user_policy_attachment.neo_cloudwatch_read_only[0].policy_arn
  )
}

output "neo_cloudwatch_policy_arn_splat" {
  value = one(concat(
    aws_iam_user_policy_attachment.neo_cloudwatch_full_access[*].policy_arn,
    aws_iam_user_policy_attachment.neo_cloudwatch_read_only[*].policy_arn
  ))
}
