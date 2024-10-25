# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}" //you can use this too
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
}