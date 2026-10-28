output "vpc_id" {
  value       = module.network.vpc_id
  description = "Created VPC ID."
}
output "private_subnet_ids" {
  value       = module.network.private_subnet_ids
  description = "Private subnet IDs by availability zone."
}
