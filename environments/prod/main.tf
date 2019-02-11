module "real_public_private_network" {
  source                     = "../../modules/public_private_network"
  nat_instance_type          = "${var.real_nat_instance_type}"
  network_name               = "${var.real_network_name}"
  private_subnet_azs         = "${var.real_private_subnet_azs}"
  private_subnet_cidr_blocks = "${var.real_private_subnet_cidr_blocks}"
  public_subnet_azs          = "${var.real_public_subnet_azs}"
  public_subnet_cidr_blocks  = "${var.real_public_subnet_cidr_blocks}"
  vpc_cidr_block             = "${var.real_vpc_cidr_block}"
}
