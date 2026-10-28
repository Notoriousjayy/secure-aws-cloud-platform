provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = var.environment
      Project     = "secure-aws-cloud-platform"
    }
  }
}

module "network" {
  source          = "../../modules/network"
  name            = "secure-cloud-${var.environment}"
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
}
