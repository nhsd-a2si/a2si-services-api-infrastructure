variable "account_id" {
  description = "ID of the AWS account in which this is being applied"
}

variable "alb_subnet_ids" {
  type        = "list"
  description = "IDs of the subnets in which to bring up the ALB"
}

variable "cluster_id" {
  description = "ID of cluster which will host this service"
}

variable "container_definition_template" {
  description = "TF template file to render to JSON which defines the containers for this service"
}

variable "default_db_host" {
  description = "Hostname to which the containers connect for their default db"
}

variable "default_db_port" {
  description = "Port to which the containers connect for their default db"
}

variable "default_db_name" {
  description = "Name of the default db to which the containers connect"
}

variable "default_db_password_parameter" {
  description = "Name of an SSM parameter in which there is an encrypted (SecureString) password with which the containers connect to their default db"
}

variable "default_db_user" {
  description = "Name of the user with which the containers connect to the default db"
}

variable "instance_subnet_cidrs" {
  type = "list"
  description = "List of CIDRs of the subnets into which the ECS instances will be launched"
}

variable "region" {
  description = "Region into which services are deployed"
}

variable "service_container_name" {
  description = "The Docker name for the main service container"
}

variable "service_container_port" {
  description = "The exposed port number for the main service container"
}

variable "service_health_path" {
  description = "Resource path for healthcheck of the service"
}

variable "service_name" {
  description = "The name of this service"
}

variable "task_desired_count" {
  description = "Desired count for number of task instances in this service"
}

variable "task_family" {
  description = "Family name for ECS task"
}

variable "vpc_id" {
  description = "VPC inside which to create the service"
}
