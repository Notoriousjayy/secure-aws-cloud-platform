# Implementation roadmap

## Phase 0 — Repository foundation
- [x] Document architecture and threat-model expectations
- [x] Add a starter private-network module
- [x] Add development environment root and explicit account allowlist
- [ ] Pin and review lockfiles after actual `terraform init` on each root
- [ ] Run Terraform formatting/validation in an execution environment

## Phase 1 — Secure control and deployment planes
- [ ] Review multi-account structure, account ownership and budgets
- [ ] Provision secure remote-state backend independently
- [ ] Implement GitHub OIDC, STS trust conditions, deployment roles and role separation
- [ ] Define independent staging and production roots

## Phase 2 — Security baseline
- [ ] Define routing, endpoint and traffic filtering decisions
- [ ] Implement CloudTrail, Config, GuardDuty, Security Hub CSPM and alert routing as appropriate
- [ ] Implement KMS/Secrets Manager permissions and runtime retrieval
- [ ] Add policy-as-code and secret scanning

## Phase 3 — Workloads and operational validation
- [ ] Deploy one representative Lambda or ECS/Fargate service
- [ ] Add observability, backups and restore drills
- [ ] Demonstrate controlled deployment to dev and staging
- [ ] Capture evidence for all six acceptance gates before production eligibility

Never treat an unchecked stage as implemented.
