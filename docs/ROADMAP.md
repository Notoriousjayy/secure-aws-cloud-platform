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

## Six-gate Taiga execution mapping (proposed, 30 October 2026)

The canonical 42-story backlog is maintained in [taiga-automation](https://github.com/Notoriousjayy/taiga-automation) and traceable here through [the implementation map](BACKLOG_TRACEABILITY.md). The 210 engineering tasks and all acceptance/evidence fields are in source-controlled JSON. The gates are **G1 isolation**, **G2 networking/IAM**, **G3 state/secrets**, **G4 module reusability**, **G5 observability/recovery**, **G6 CI/CD governance**.

No gate is marked accepted until integration checks, denial tests and evidence review succeed. In particular, Phase 0 checked items represent scaffolding, not deployed AWS services. Source-of-truth documentation is in [latex-docs](https://github.com/Notoriousjayy/latex-docs); infrastructure source and integration evidence belong here.

### Execution prerequisites

- G1: resolve ownership, approved account topology, environment isolation ADR and service responsibility.
- G2: review routing, network boundaries, IAM contracts, GitHub OIDC subject and claim restrictions.
- G3: independently bootstrap private/encrypted/versioned S3 state with native locking and recovery checks.
- G4: compose typed modules in isolated dev and staging accounts, selecting one workload by ADR.
- G5: implement logging/detection/alerts and a measured recovery exercise.
- G6: add policy tests, approved plans and protected deployment; never treat current static validation as applied infrastructure.

**Current automation boundary:** `.github/workflows/terraform-validate.yml` remains non-deploying. Do not add AWS access keys or infer authorization to deploy from a Taiga import.
