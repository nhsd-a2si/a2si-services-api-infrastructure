variable "alb_subnet_ids" {
  type        = "list"
  description = "IDs of the subnets in which to bring up the ALB"
}

variable "cluster_id" {
  description = "ID of cluster which will host this service"
}

variable "container_definitions" {
  description = "JSON containing the definition of the containers for this service"
}

variable "instance_subnet_cidrs" {
  type = "list"
  description = "List of CIDRs of the subnets into which the ECS instances will be launched"
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
