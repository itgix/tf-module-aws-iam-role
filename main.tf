# IAM Role that can be assumed by Terraform for cross account accesss 
resource "aws_iam_role" "default" {
  #   name = "itgix-landing-zones"
  name = var.role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          # Account from where this role will be assumed
          # at the moment this is the management account
          # TODO: can we take this dynamically or figure out how to pass account IDs to all the places that need them
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
      },
    ]
  })

  managed_policy_arns = { for k, v in aws_iam_policy.default : k => v.arn }

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "default" {
  for_each = var.iam_policies

  name   = each.value.name
  policy = each.value.policy
}