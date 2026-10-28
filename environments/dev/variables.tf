variable "aws_region" {
  type        = string
  description = "AWS deployment region."
  default     = "us-east-2"
}
variable "aws_account_id" {
  type        = string
  description = "Exact target AWS account ID; never use an unreviewed fallback."
  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "An explicit 12-digit AWS account ID is required."
  }
}
variable "environment" {
  type        = string
  description = "Logical deployment environment."
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
variable "vpc_cidr" {
  type        = string
  description = "Environment VPC address space."
}
variable "private_subnets" {
  type        = map(string)
  description = "Availability zone to private-subnet CIDR."
}
