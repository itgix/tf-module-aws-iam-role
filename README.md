The Terraform module is used by the ITGix AWS Landing Zone - https://itgix.com/itgix-landing-zone/

# AWS IAM Role Terraform Module

This module creates an IAM role with custom inline policies and configurable trust relationships.

Part of the [ITGix AWS Landing Zone](https://itgix.com/itgix-landing-zone/).

## Resources Created

- IAM role with assume role policy
- IAM policies (inline)
- Policy attachments

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `enabled` | Enable or Disable the module | `bool` | `false` | no |
| `role_name` | Name of the role | `string` | — | yes |
| `iam_policies` | Map of IAM policies to create and attach | `map(object({name=string, policy=string}))` | — | yes |
| `principals` | Trust relationship principals | `map(any)` | — | yes |

## Outputs

| Name | Description |
|------|-------------|
| `iam_policy_arns` | Map of created IAM policy ARNs |

## Usage Example

```hcl
module "iam_role" {
  source = "path/to/tf-module-aws-iam-role"

  enabled   = true
  role_name = "my-custom-role"

  principals = {
    Service = ["lambda.amazonaws.com"]
  }

  iam_policies = {
    logs = {
      name   = "cloudwatch-logs"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect   = "Allow"
          Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
          Resource = "*"
        }]
      })
    }
  }
}
```
