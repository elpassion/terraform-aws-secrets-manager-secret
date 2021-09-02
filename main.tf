module "label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25.0"
  enabled = var.enabled

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes

  delimiter = var.delimiter


  tags = var.tags
}

resource "aws_secretsmanager_secret" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = module.label.id
  description = var.description

  tags = module.label.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = var.secret_string

  lifecycle {
    ignore_changes = [secret_string]
  }
}

data "aws_iam_policy_document" "read_secret" {
  count = var.enabled ? 1 : 0
  statement {
    sid    = "ReadSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [aws_secretsmanager_secret.this[0].arn]
  }
}

resource "aws_iam_policy" "read_secret" {
  count  = var.enabled ? 1 : 0
  name   = "${var.name}-read-secret"
  policy = data.aws_iam_policy_document.read_secret[0].json
}
