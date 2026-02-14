module "bootstrap" {
  source  = "trussworks/bootstrap/aws"
  version = "7.0.0"

  region               = var.aws_region
  account_alias        = var.account_alias
  manage_account_alias = false
}
