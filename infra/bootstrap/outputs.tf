output "state_bucket" {
  description = "S3 bucket name used as Terraform backend."
  value       = module.bootstrap.state_bucket
}

output "dynamodb_table" {
  description = "DynamoDB table name used for Terraform state locking."
  value       = module.bootstrap.dynamodb_table
}
