# Terraform Beginner Bootcamp 2023
<img width="1066" alt="Screenshot 2023-10-04 at 1 28 09 PM" src="https://github.com/rnfor-pro/terraform-beginner-bootcamp-2023/assets/67124388/6caa35a6-3a95-4148-82d0-2b2b432f6df2">

### weekly journals

- [Week 0 Journal](journal/week0.md)
- [Week 1 Journal](journal/week0.md)

  ## Extras
  
- [Github Markdown TOC Generator](https://ecotrust-canada.github.io/markdown-toc/)

## Dealing with Configuration Drift

## What happens if we lose our state file

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resource with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configuration

When any resource created terraform is modified or deleted by hand, if we run `terraform plan` it will attempt to put our infrastructure back nto the expected state fixing Configuration Drift. 

