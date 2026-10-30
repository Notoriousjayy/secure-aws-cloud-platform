# Reusable Secure AWS Cloud Environment — Taiga-to-Terraform traceability

**Status:** Proposed engineering backlog, not an AWS deployment. Machine-readable index: [backlog-traceability.json](backlog-traceability.json).

Sources: [Taiga canonical backlog](https://github.com/Notoriousjayy/taiga-automation/blob/main/data/stories/secure-aws-cloud-backlog.json) · [Architecture documents](https://github.com/Notoriousjayy/latex-docs/tree/main/src/architecture/cloud/reusable-secure-aws-cloud-environment)

## Current reality

The repository has a starter private VPC module, a dev root with `allowed_account_ids` and non-deploying Terraform validation. The remote state backend, staging/production roots, CI deployment identities, observability and recovery modules are not yet functional. Do not interpret a directory as implementation evidence.

## Gate ownership

| Gate | Accountable implementation areas | Closure criteria |
| --- | --- | --- |
| G1 | docs/adr/0001-environment-isolation.md; docs/architecture/README.md; docs/threat-model/README.md | Reviewed account boundary and denied cross-account access |
| G2 | modules/network/; modules/network-security/; modules/identity/ | Allowlisted network paths, scoped IAM, and failed prohibited access |
| G3 | bootstrap/terraform-state/; modules/data-protection/ | Encrypted/versioned/locked state with recovery and secret isolation |
| G4 | modules/; environments/dev/; environments/staging/ (planned) | Reused module version across independently governed dev/staging |
| G5 | modules/observability/; modules/backup-recovery/; modules/cost-management/ | Security signals, alarm ownership, and RPO/RTO-tested recovery |
| G6 | .github/workflows/terraform-validate.yml; policies/; tests/ | PR policy tests, reviewed plans, short-lived OIDC, enforced production approvals |

## Story implementation map

| Source ID | Gate | Engineering outcome | Terraform path | Prerequisites |
| --- | --- | --- | --- | --- |
| SC-G1-01 | G1 | Review AWS account topology and ownership | `docs/architecture` | None |
| SC-G1-02 | G1 | Document cloud shared-responsibility boundaries | `docs/architecture` | SC-G1-01 |
| SC-G1-03 | G1 | Approve development staging and production account isolation | `docs/adr` | SC-G1-01 |
| SC-G1-04 | G1 | Establish architecture requirements and ADR register | `docs/architecture` | SC-G1-01, SC-G1-03 |
| SC-G1-05 | G1 | Develop the initial AWS threat model | `docs/threat-model` | SC-G1-03 |
| SC-G1-06 | G1 | Define resource ownership tagging and cost boundaries | `modules/cost-management` | SC-G1-01 |
| SC-G1-07 | G1 | Approve G1 isolation acceptance evidence | `tests` | SC-G1-02, SC-G1-03, SC-G1-04, SC-G1-05, SC-G1-06 |
| SC-G2-01 | G2 | Harden existing private VPC network module | `modules/network` | SC-G1-03 |
| SC-G2-02 | G2 | Specify egress and route-table policy | `modules/network-security` | SC-G2-01 |
| SC-G2-03 | G2 | Implement validated VPC endpoint patterns | `modules/network` | SC-G2-01, SC-G2-02 |
| SC-G2-04 | G2 | Deliver reusable least-privilege IAM module | `modules/identity` | SC-G1-03 |
| SC-G2-05 | G2 | Constrain GitHub Actions to AWS STS OIDC roles | `modules/identity` | SC-G2-04 |
| SC-G2-06 | G2 | Validate negative identity and network access | `tests` | SC-G2-02, SC-G2-03, SC-G2-04, SC-G2-05 |
| SC-G2-07 | G2 | Approve G2 network and IAM acceptance evidence | `tests` | SC-G2-01, SC-G2-02, SC-G2-03, SC-G2-04, SC-G2-05, SC-G2-06 |
| SC-G3-01 | G3 | Bootstrap independently governed development S3 state | `bootstrap/terraform-state` | SC-G1-03, SC-G2-04 |
| SC-G3-02 | G3 | Enforce state-object and lockfile IAM scoping | `bootstrap/terraform-state` | SC-G3-01 |
| SC-G3-03 | G3 | Test S3 native state locking and recovery | `tests` | SC-G3-01, SC-G3-02 |
| SC-G3-04 | G3 | Implement encryption and KMS key-policy baseline | `modules/data-protection` | SC-G3-01 |
| SC-G3-05 | G3 | Provision secret containers and scoped runtime access | `modules/data-protection` | SC-G2-04, SC-G3-04 |
| SC-G3-06 | G3 | Validate Terraform and GitHub secret-leakage controls | `policies` | SC-G3-04, SC-G3-05 |
| SC-G3-07 | G3 | Approve G3 state and secrets assurance evidence | `tests` | SC-G3-01, SC-G3-02, SC-G3-03, SC-G3-04, SC-G3-05, SC-G3-06 |
| SC-G4-01 | G4 | Define module input-output and versioning contracts | `modules` | SC-G1-04, SC-G3-01 |
| SC-G4-02 | G4 | Implement reusable network-security module contract | `modules/network-security` | SC-G2-01, SC-G4-01 |
| SC-G4-03 | G4 | Implement baseline monitoring and policy modules | `modules/security-baseline` | SC-G2-04, SC-G3-04, SC-G4-01 |
| SC-G4-04 | G4 | Select and design the initial compute workload | `docs/adr` | SC-G4-01, SC-G4-02 |
| SC-G4-05 | G4 | Implement isolated dev and staging environment roots | `environments/dev` | SC-G1-03, SC-G3-02, SC-G4-01, SC-G4-02, SC-G4-03 |
| SC-G4-06 | G4 | Deploy representative application into isolated environments | `modules/compute` | SC-G3-05, SC-G4-04, SC-G4-05 |
| SC-G4-07 | G4 | Approve G4 module reusability acceptance | `tests` | SC-G4-01, SC-G4-02, SC-G4-03, SC-G4-04, SC-G4-05, SC-G4-06 |
| SC-G5-01 | G5 | Establish CloudTrail CloudWatch and Config baselines | `modules/observability` | SC-G4-03, SC-G4-05 |
| SC-G5-02 | G5 | Integrate GuardDuty Security Hub and IAM Access Analyzer | `modules/security-baseline` | SC-G4-03, SC-G5-01 |
| SC-G5-03 | G5 | Configure alarms SLOs and alert ownership | `modules/observability` | SC-G4-06, SC-G5-01 |
| SC-G5-04 | G5 | Define backup retention and workload recovery objectives | `modules/backup-recovery` | SC-G4-06, SC-G5-01 |
| SC-G5-05 | G5 | Run a restore drill and document recovery evidence | `tests` | SC-G5-04 |
| SC-G5-06 | G5 | Implement cost visibility and budget notifications | `modules/cost-management` | SC-G1-06, SC-G4-05 |
| SC-G5-07 | G5 | Approve G5 operational and recovery evidence | `tests` | SC-G5-01, SC-G5-02, SC-G5-03, SC-G5-04, SC-G5-05, SC-G5-06 |
| SC-G6-01 | G6 | Harden Terraform validation and lockfile verification | `.github/workflows` | SC-G4-01 |
| SC-G6-02 | G6 | Integrate policy-as-code and IaC vulnerability scans | `policies` | SC-G3-06, SC-G6-01 |
| SC-G6-03 | G6 | Publish protected Terraform plans with independent review | `.github/workflows` | SC-G2-05, SC-G3-01, SC-G6-01, SC-G6-02 |
| SC-G6-04 | G6 | Implement OIDC-authenticated dev and staging deployment | `.github/workflows` | SC-G2-05, SC-G4-05, SC-G6-03 |
| SC-G6-05 | G6 | Protect production promotion with independent approval | `.github/workflows` | SC-G1-03, SC-G6-03, SC-G6-04 |
| SC-G6-06 | G6 | Automate drift detection and controlled recovery | `tests` | SC-G6-04, SC-G6-05 |
| SC-G6-07 | G6 | Approve cross-gate production readiness evidence | `tests` | SC-G1-07, SC-G2-07, SC-G3-07, SC-G4-07, SC-G5-07, SC-G6-01, SC-G6-02, SC-G6-03, SC-G6-04, SC-G6-05, SC-G6-06 |

## Required per-story closeout

1. Read the canonical Taiga source record and its prerequisite identifiers.
2. Review this repository's actual Terraform source and relevant ADR before implementing.
3. Produce a PR with code and tests. Cross-environment and unauthorized access cases require negative tests.
4. Link CI runs, security scan outputs, reviewer decisions and evidence references; avoid storing secrets or live account IDs in public GitHub.
5. Mark a story complete only after objective evidence and gate reviewer acceptance.

Do not automatically deploy production from backlog updates, and do not assume Taiga story statuses are evidence of AWS control effectiveness.

## First iteration

Review and refine SC-G1-01 through SC-G1-05, SC-G2-04 and SC-G3-01; use ADR review and bootstrap design before any AWS provisioning. Story points and dates remain unestimated.

## Import lifecycle boundary

Rich Taiga import is a separate, approval-gated workflow in `taiga-automation`. This repository does not need Taiga credentials. No automatic GitHub cross-repository workflow trigger is authorized by this traceability index.
