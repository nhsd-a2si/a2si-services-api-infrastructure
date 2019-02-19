variable "ecs_cluster_arn" {
  description = "The ARN of the cluster over which to give the user ECS deployment rights"
}

variable "ecs_cluster_name" {
  description = "The name of the cluster over which to give the user ECS deployment rights"
}

variable "operator_pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists. Will be used to encrypt output of IAM user credentials. See https://keybase.io"
}
