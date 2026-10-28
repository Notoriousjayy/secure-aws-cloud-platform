# Terraform state backend bootstrap (not implemented)

Create state storage **outside** the environment roots, under an authorized bootstrap identity.

Required controls: S3 Block Public Access, bucket-owner-enforced ownership, versioning, encryption with reviewed KMS policy, limited per-environment object and lock permissions, audit logging and a restore exercise. Use dedicated production authorization and state scopes. Protect the bootstrap itself from accidental destruction.

After provisioning, configure an S3 backend for each environment with an explicitly reviewed bucket, key and region. For supported Terraform versions, use native `use_lockfile = true`. Do **not** commit secrets or raw state. `sensitive = true` does not guarantee the exclusion of values from state.

Example **only** (do not copy without replacing identifiers and reviewing access):

```hcl
terraform {
  backend "s3" {
    bucket       = "YOUR-EXISTING-STATE-BUCKET"
    key          = "platform/dev/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}
```

No state backend resources are created by this repository yet.
