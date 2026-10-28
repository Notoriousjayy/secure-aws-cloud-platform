# Acceptance and verification plan

- G1: Account and trust boundaries documented; development cannot impersonate production.
- G2: Least-privilege IAM and intended-only network flows; negative access tests.
- G3: Encrypted, private, versioned state, backend locking and secret leakage checks.
- G4: Reusable module inputs/outputs, reproducible deployment to dev and staging.
- G5: Security alerts route to owners; documented restore meets RTO/RPO.
- G6: CI policy checks and explicit production approval protect deployments.

Current status: **not executed**. `terraform validate` is syntax/configuration validation, not a claim of infrastructure or security control effectiveness.
