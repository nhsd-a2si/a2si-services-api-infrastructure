variable "nat_instance_type" {
  description = "Instance type to use for the NAT instance"
}

variable "network_name" {
  description = "Name of the network being set up by this module"
}

variable "private_subnet_cidr_blocks" {
  type        = "list"
  description = "CIDR blocks for the private subnets"
}

variable "private_subnet_azs" {
  type        = "list"
  description = "Availability Zones for the public subnets"
}

variable "public_subnet_cidr_blocks" {
  type        = "list"
  description = "CIDR blocks for the public subnets"
}

variable "public_subnet_azs" {
  type        = "list"
  description = "Availability Zones for the public subnets"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}
