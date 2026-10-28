# Network module

Creates one VPC with DNS support, private subnets in at least two distinct availability zones, and dedicated route tables with **no internet default routes**.

Inputs: `name`, `vpc_cidr`, `private_subnets` (AZ -> CIDR), optional `tags`.

Outputs: `vpc_id`, `private_subnet_ids`, `private_route_table_ids`.

## Scope and limitations

No NAT, internet gateway, VPN, VPC endpoints, security groups, flow logs or DNS resolver rules. These are separate control decisions and **must be implemented before workloads require them**. No outbound internet access is implied by placement in a private subnet; default security group behavior and any new network connections require separate review.

Caller is responsible for non-overlapping CIDRs, available AZs and subnet size. Protect environment account scope through `allowed_account_ids` at the root provider.
