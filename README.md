# a2si-services-api-infrastructure

Infrastructure code for the [a2si-services-api](https://github.com/nhsd-a2si/a2si-services-api)
project.

After applying this Terraform, the following outputs will be generated:

  - _real_api_service_fqdn_ - This is the DNS 'A' entry for the Real API's Application Load Balancer endpoint

## Setting up the Terraform backend

```
$ terraform init --backend-config=environments/prod/s3backend.tfvars environments/prod
```

## Applying Terraform

```
$ terraform apply environments/prod
```
