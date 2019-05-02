/*
 * REQUIRED VARIABLES AT RUNTIME
 */
variable "operator_pgp_key" {
  type        = "string"
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists. Will be used to encrypt output of IAM user credentials. See https://keybase.io"
}

variable "real_api_default_db_password_parameter" {
  type = "string"
  description = "Name of an SSM parameter in which there is an encrypted (SecureString) password for the default db for the Real API"
}

/*
 * REAL GENERAL VARIABLES
 */
variable "real_network_name" {
  default = "ProdReal"
}

variable "real_nat_instance_type" {
  default = "t2.micro"
}

variable "real_private_subnet_azs" {
  type    = "list"
  default = [
    "eu-west-2a",
    "eu-west-2c"
  ]
}

variable "real_private_subnet_cidr_blocks" {
  type    = "list"
  default = [
    "10.1.129.0/24",
    "10.1.130.0/24"
  ]
}

variable "real_public_subnet_azs" {
  type    = "list"
  default = [
    "eu-west-2a",
    "eu-west-2c"
  ]
}

variable "real_public_subnet_cidr_blocks" {
  type    = "list"
  default = [
    "10.1.1.0/24",
    "10.1.2.0/24"
  ]
}

variable "real_vpc_cidr_block" {
  default = "10.1.0.0/16"
}

variable "real_zone_name" {
  default = "a2sisap.mcbhenwood.com."
}

/*
 * REAL API SERVICE & CLUSTER VARIABLES
 */
variable "real_api_default_db_allocated_storage_gb" {
  default = 20
}

variable "real_api_default_db_engine" {
  default = "postgres"
}

variable "real_api_default_db_engine_version" {
  default = "11.1"
}

variable "real_api_default_db_instance_class" {
  default = "db.t2.micro"
}

variable "real_api_default_db_name" {
  default = "defaultdb"
}

variable "real_api_default_db_port" {
  default = 5432
}

variable "real_api_default_db_storage_type" {
  default = "gp2"
}

variable "real_api_default_db_user" {
  default = "defaultdb"
}

variable "real_api_dns_name" {
  default = "api.a2sisap.mcbhenwood.com"
}

variable "real_api_ecs_cluster_name" {
  default = "ProdRealAPI"
}

variable "real_api_ecs_instance_type" {
  default = "t2.micro"
}

variable "real_api_service_name" {
  default = "ProdRealAPI"
}

variable "real_api_task_desired_count" {
  default = 2
}

variable "real_api_max_autoscaling_group_size" {
  default = 4
}

variable "real_api_min_autoscaling_group_size" {
  default = 2
}

variable "real_api_static_dns_name" {
  default = "static.a2sisap.mcbhenwood.com"
}

/*
 * SERVICE-SPECIFIC VARIABLES
 */
variable "api_service_health_path" {
  default = "/health"
}
