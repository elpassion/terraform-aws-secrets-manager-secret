module "label" {
  source     = "cloudposse/label/null"
  version    = "~> 0.25.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  delimiter  = var.delimiter
  tags       = var.tags
}

data "aws_iam_policy_document" "combined_policy" {
  dynamic "statement" {
    for_each = var.policy_documents
    content {
      actions   = jsondecode(statement.value).statements[0].actions
      resources = jsondecode(statement.value).statements[0].resources
    }
  }
}

resource "aws_iam_policy" "combined_policy" {
  name   = module.label.id
  policy = data.aws_iam_policy_document.combined_policy.json
}