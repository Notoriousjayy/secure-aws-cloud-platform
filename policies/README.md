# Security-policy objectives

Policy-as-code is **not yet implemented**. Prior to deployment, enforce or test:

- Deny broad IAM permissions and unrestricted cross-account role trust.
- Restrict GitHub OIDC trust by organization/repository, workflow context, environment and audience.
- Block public S3 access; require approved encryption and retention.
- Reject unintended public ingress and undocumented default routes.
- Block committed credentials and secret values; use secret references and workload identities.
- Require production plans, approvals, audit logs and recovery evidence.

Candidate tooling: Checkov/Trivy for static IaC scanning and OPA/Conftest for custom policy rules. Pin tool versions and document suppression ownership before making a production gate.
