# ADR-0001: Isolate deployment environments by AWS account

- Status: Proposed
- Date: 2026-10-28

## Context
A production workload must not share privileged identity or Terraform state authorization with development workloads.

## Decision
Use distinct AWS accounts for development, staging and production, independently scoped deployment roles, and separate state object boundaries. The root AWS provider must explicitly limit the target account ID.

## Consequences
Additional account and backend bootstrap effort; more auditable blast-radius and change boundaries. Shared governance and central security services require clearly documented ownership.

## Acceptance
Verify a development deployment identity cannot assume the production deployment role or read production state.
