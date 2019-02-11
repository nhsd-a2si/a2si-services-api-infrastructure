# a2si-services-api-infrastructure

Infrastructure code for the [a2si-services-api](https://github.com/nhsd-a2si/a2si-services-api)
project.

## Setting up the Terraform backend

```
$ terraform init --backend-config=environments/prod/s3backend.tfvars environments/prod
```
