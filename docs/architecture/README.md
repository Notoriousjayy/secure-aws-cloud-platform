# Architecture overview

Reference planes: (1) control and governance, (2) deployment through GitHub OIDC and AWS STS, (3) isolated AWS workload accounts, and (4) security/audit telemetry.

## Mandatory invariants

1. Dev, staging, and prod must have independent AWS account boundaries, deploy roles, and Terraform state namespaces.
2. IAM access uses least privilege, short-lived credentials and MFA for human access.
3. Network communication is explicit; restricted egress, VPC endpoints and flow logs are separate decisions.
4. Applications read secrets from authorized secret stores at runtime; do not commit secret values.
5. Telemetry, finding ownership, log retention, recovery objectives and restoration tests are required.
6. Production changes require reviewed plans, policy gates and approval.

## Implementation status

Implemented: standalone private-network Terraform module and a dev root with account allowlisting.

Not implemented: organization/account provisioning; IAM/OIDC roles; VPC endpoints; workload security groups; KMS/secrets policies; central audit; GuardDuty/Config; workload runtimes; backups; secure remote backend; staging/prod roots. No completed security posture should be inferred from this scaffold.
