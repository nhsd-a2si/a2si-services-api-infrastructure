variable "real_network_name" {
  default = "ProdReal"
}

variable "real_nat_instance_type" {
  default = "t2.small"
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
