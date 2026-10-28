output "vpc_id" {
  description = "ID of the private network VPC."
  value       = aws_vpc.this.id
}
output "private_subnet_ids" {
  description = "AZ => subnet ID for private workloads."
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}
output "private_route_table_ids" {
  description = "AZ => dedicated private route table ID."
  value       = { for az, rt in aws_route_table.private : az => rt.id }
}
