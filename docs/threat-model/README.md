# Threat model worksheet

For each trust boundary document: assets, data classifications, actors, entry points, threats, controls, residual risk, owner and repeatable test evidence.

Initial required scenarios:

1. Cross-account role assumption from dev into prod.
2. Terraform state disclosure and restore from prior object versions.
3. Compromised GitHub Actions workflow and unauthorized apply.
4. One workload reading another workload's secret.
5. Unexpected public ingress or unauthorized egress.
6. Deletion or corruption of logs, backups, secrets or KMS keys.

No threat-control claim is complete without test evidence.
