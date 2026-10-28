# Secure AWS Cloud Platform

A security-first, reusable AWS cloud environment foundation built with Terraform.

> **Status:** Initial engineering scaffold. This repository is not yet production-ready and does not deploy infrastructure automatically.

## Goals

- Reuse versioned Terraform module contracts across isolated development, staging, and production AWS accounts.
- Establish least-privilege IAM, private networking, protected Terraform state, runtime secret retrieval, auditability, and recovery controls.
- Keep credentials and secret values out of Git, ordinary `.env` files, Terraform state where avoidable, and CI logs.
- Use GitHub Actions for validation before introducing protected, OIDC-authenticated deployment workflows.

## Repository map

- `bootstrap/terraform-state/` — isolated state-backend bootstrap guidance.
- `modules/` — network implementation and planned security/platform module contracts.
- `environments/{dev,staging,prod}/` — independently configured Terraform root modules.
- `policies/` — documented control objectives and future policy-as-code.
- `tests/` — acceptance gates and negative-security test plan.
- `docs/architecture/`, `docs/threat-model/`, `docs/adr/` — design, threats and architectural decisions.
- `.github/workflows/` — non-deploying Terraform validation workflow.

## Quick start: validation only

Install Terraform (compatible with `required_version`) and run:

```bash
terraform fmt -check -recursive
terraform -chdir=environments/dev init -backend=false
terraform -chdir=environments/dev validate
```

No AWS credentials are necessary for configuration validation. Planning or applying **does** require an authorized AWS role, a separately bootstrapped S3 backend, reviewed configuration, and a designated AWS account.

**Do not run `terraform apply` until the environment's security and state backend prerequisites are complete.**

## Required separation of environments

Production must use a distinct AWS account, deployment role and Terraform state scope. Each root provider sets `allowed_account_ids` to help prevent deploying into the wrong account. A network-only starter module is included; security-baseline and application modules are explicitly planned, not represented as completed.

## Secrets policy

Commit only nonsecret config and references to secret identifiers (see `.env.example`). Use workload roles and AWS Secrets Manager for runtime access. Never commit `.env`, `*.tfvars` containing deployment details, Terraform state, or plan files.

## Roadmap

See [implementation gates](docs/ROADMAP.md), [architecture](docs/architecture/README.md), and [security control objectives](policies/README.md).

## Architectural reference

This project implements the companion design principles in *Reusable Secure AWS Cloud Environment: Architecture, Learning Crosswalk, and Terraform Implementation Roadmap* (v1.0, 28 October 2026). It builds on the vendor-neutral concepts of *Cloud Computing: Concepts, Technology, Security & Architecture*, 2nd edition (Thomas Erl and Eric Barceló Monroy), without attributing AWS-specific Terraform implementation details to that book.
