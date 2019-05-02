# a2si-services-api-infrastructure

Infrastructure code for the [a2si-services-api](https://github.com/nhsd-a2si/a2si-services-api)
project.

You will need Terraform installed (or preferably to have a Docker image which runs Terraform for
you).

Some of the output is PGP encoded for security reasons and you may find it easier to work with this
aspect if you install [Keybase](https://keybase.io) for your machine.

See section [Applying Terraform](#applying-terraform) for details of command line variables etc.

After applying this Terraform, the following outputs will be generated and displayed in your terminal:

  - _real_api_cluster_ - The name of the cluster into which the Real API Service was deployed

  - _real_api_service_name_ - The internal name of the Real API Service at ECS

  - _real_api_service_fqdn_ - This is the DNS 'A' entry for the Real API's Application Load Balancer
     endpoint

  - _real_api_static_fqdn_ -  This is the DNS 'A' entry for the Real API's Static assets website
     endpoint
  
  - _deploy_user_access_key_id_ - The key id for the deployment user: You will need to
    provide this to CI environment so that when building the pipeline it can update the ECS
    services with the new service images pushed to Docker Hub.
  
  - _deploy_user_secret_access_key_encrypted_ - Encrypted version of the secrest access key for the
    deployment user: You will need to provide this to CI environment so that when building the
    pipeline it can update the ECS services with the new service images pushed to Docker Hub.
  
## Converting the encrypted secret access key
 
The actual AWS secret access key is PGP encoded (with the key you supply at `apply` time) then
Base 64 encoded so it can be rendered in a terminal.
 
To convert it into the actual secret access key, you therefore need to:
 
  1. Base 64 decode the _deploy_user_secret_access_key_encrypted_ output

  2. Run that output through a PGP decoder with the same key you supplied at `apply` time
   
If you installed Keybase as suggested above, then you:

  1. Copy the long output of _deploy_user_secret_access_key_encrypted_ to your clipboard
   
  2. Type the following, pausing to paste the above copy in this command line, in place of
     THECOPIEDOUTPUT:

   `echo -n "THECOPIEDOUTPUT" | base64 --decode - | keybase pgp decrypt` 

This will display the actual secret access key in your terminal so be aware of this before you run
the step.

## Setting up the Terraform backend

```
$ terraform init --backend-config=environments/prod/s3backend.tfvars environments/prod
```

## Applying Terraform

```
$ terraform apply \
  -var "operator_pgp_key=SOME_PGP_KEY" \
  -var "real_api_default_db_password_parameter=SOME_SSM_PARAMETER_NAME" \
  environments/prod
```

`operator_pgp_key` is either a base-64 encoded PGP public key, or a keybase username in the form
keybase:some_person_that_exists. Will be used to encrypt output of IAM user credentials.
See https://keybase.io

`real_api_default_db_password_parameter` is the ARN of an AWS Systems Manager parameter. This
parameter must already be set to a suitably secure password value before the Terraform is applied.
Its value must be a string which is the password to use for connecting to the "default db" for the
Real API - This is the db which Django uses to manage sessions, state, user accounts and API access
tokens. Applying the Terraform will have the effect of a) setting this password as the access
password for the relevant RDS instance and b) becoming the password which is passed securely to any
new ECS containers in the Real API service, so that they may access the db. If you change the value
of this secret you will need to re-apply the Terraform so that new ECS containers will be made
aware of the new credential. If you change the value _without_ then re-applying the Terraform, you
will cut off any new ECS containers from being able to access their db.
