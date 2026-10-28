variable "name" {
  description = "Resource namespace for this network."
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,40}$", var.name))
    error_message = "name must be lowercase kebab-case, 3-41 characters."
  }
}
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "Supply a valid IPv4 CIDR."
  }
}
variable "private_subnets" {
  description = "Map of AZ names to private subnet CIDR blocks; at least two AZs."
  type        = map(string)
  validation {
    condition     = length(var.private_subnets) >= 2 && alltrue([for cidr in values(var.private_subnets) : can(cidrnetmask(cidr))])
    error_message = "Provide valid private IPv4 subnet CIDRs in at least two AZs."
  }
}
variable "tags" {
  description = "Nonsecret tags applied to all resources."
  type        = map(string)
  default     = {}
}
