output "secret_arn" {
  value = concat(aws_secretsmanager_secret.this.*.arn, [""])[0]
}

output "secret_name" {
  value = concat(aws_secretsmanager_secret.this.*.name, [""])[0]
}

output "secret_id" {
  value = concat(aws_secretsmanager_secret.this.*.id, [""])[0]
}

output "iam_policy_arn_read_secret" {
  value       = concat(aws_iam_policy.read_secret.*.arn, [""])[0]
  description = "ARN of an IMA policy, that allows read access to the secret."
}