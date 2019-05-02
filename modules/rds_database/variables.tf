variable "allocated_storage_gb" {
  description = "Amount of storage (in GB) to assign to each instance"
}

variable "engine" {
  description = "Database engine"
}

variable "engine_version" {
  description = "Version of the database engine"
}

variable "instance_class" {
  description = "Types of database instances"
}

variable "name" {
  description = "Name to give the database"
}

variable "password_parameter" {
  description = "Name of SSM parameter containing SecureString version of required db password"
}

variable "port" {
  description = "TCP port on which to access the database"
}

variable "storage_type" {
  description = "Storage type for the instance"
}

variable "subnet_ids" {
  type        = "list"
  description = "IDs for the subnets with which to create the db subnet group"
}

variable "username" {
  description = "Name to assign to db access account"
}

