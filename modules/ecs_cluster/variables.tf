variable "alb_security_group_id" {
  description = "Security group ID of the ALB which will want to forward to containers on these instances"
}

variable "alb_subnet_cidrs" {
  type = "list"
  description = "List of the CIDRs of the subnets to which the ALB is attached"
}

variable "cluster_name" {
  description = "Unique (across account) name for the ECS cluster"
}

variable "cluster_subnet_cidrs" {
  type = "list"
  description = "CIDR blocks for the subnets into which to launch the cluster instances"
}

variable "cluster_subnet_ids" {
  type = "list"
  description = "Subnets into which to launch the cluster instances"
}

variable "default_db_client_security_group_id" {
  description = "ID for the security group into which DB clients need to be added"
}

variable "default_db_port" {
  description = "Port for which to allow outgoing DB connections"
}

variable "default_db_security_group_id" {
  description = "ID for the security group of the DB instance"
}

variable "instance_type" {
  description = "Instance type to use for the ECS instances"
}

variable "max_autoscaling_group_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_autoscaling_group_size" {
  description = "Minimum number of instances in the cluster"
}

variable "vpc_id" {
  description = "VPC inside which to create the cluster"
}
