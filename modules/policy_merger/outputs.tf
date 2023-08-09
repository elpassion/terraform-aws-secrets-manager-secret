output "combined_policy_arn" {
  value = aws_iam_policy.combined_policy.arn
}

output "combined_policy_json" {
  value = aws_iam_policy.combined_policy.policy
}