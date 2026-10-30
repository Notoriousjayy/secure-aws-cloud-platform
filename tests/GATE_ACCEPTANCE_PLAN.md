# Six architecture acceptance gates — verification and evidence plan

This is a **test plan**, not a test report. Current repository status is validation-only; no production AWS deployment or control effectiveness has been demonstrated.

| Gate | Positive path | Required negative path | Evidence record |
| --- | --- | --- | --- |
| G1 | Environment account roles and ownership approved | Dev identity cannot assume production role/read production state | Reviewed ADR and IAM denial test |
| G2 | Required AWS service endpoints reachable only on reviewed routes | Prohibited ingress, egress, and cross-account STS denied | Network matrix and reachability logs |
| G3 | State backend encryption, versioning, locking, recovery | Unauthorized state/secret reads fail; invalid concurrent apply blocked | Restore run and access-denial checks |
| G4 | Same pinned module version composes isolated dev and staging | Wrong allowed account and unapproved module input rejected | Successful dev/staging validations and smoke checks |
| G5 | Alerts route to named owners; restore meets RPO/RTO | Misrouted alarm, corrupted backup or unmet RTO fails acceptance | Drill timeline and alert-run evidence |
| G6 | Protected deploy uses correct short-lived OIDC role | Wrong repo/ref/account or missing prod approval denied | CI logs, independent approval, denied OIDC test |

## Test execution classifications

- Static: formatting, parsing, Terraform validate, policy fixtures; can run without AWS auth.
- Authorized integration: role assumption, endpoint reachability, backend lock and restore; require scoped AWS accounts.
- Production promotion: only after all gate records are reviewed and independent approvals are enforced.

Never use simulated or mocked results to claim integrated AWS acceptance. Evidence links must be access controlled and redact account identifiers, credentials and plans where necessary.
