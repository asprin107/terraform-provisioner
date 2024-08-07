output "irsa-policy-name" {
  value = aws_iam_policy.irsa-kyverno.name
}

output "irsa-role-name" {
  value = module.irsa_role.role_name
}

output "irsa-role-arn" {
  value = module.irsa_role.role_arn
}