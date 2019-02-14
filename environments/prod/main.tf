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

module "real_api_service" {
  source                 = "../../modules/ecs_balanced_service"
  alb_subnet_ids         = "${module.real_public_private_network.public_subnet_ids}"
  cluster_id             = "${module.real_api_ecs_cluster.cluster_id}"
  instance_subnet_cidrs  = "${module.real_public_private_network.private_subnet_cidrs}"
  service_container_name = "api"
  service_container_port = 8000
  container_definitions  = "${file("${path.module}/task_definitions/api_service.json")}"
  service_health_path    = "${var.api_service_health_path}"
  service_name           = "${var.real_api_service_name}"
  task_desired_count     = "${var.real_api_task_desired_count}"
  task_family            = "${var.real_api_service_name}"
  vpc_id                 = "${module.real_public_private_network.vpc_id}"
}

module "real_api_ecs_cluster" {
  source                     = "../../modules/ecs_cluster"
  alb_security_group_id      = "${module.real_api_service.alb_security_group_id}"
  alb_subnet_cidrs           = "${module.real_public_private_network.public_subnet_cidrs}"
  cluster_subnet_cidrs       = "${module.real_public_private_network.private_subnet_cidrs}"
  cluster_subnet_ids         = "${module.real_public_private_network.private_subnet_ids}"
  cluster_name               = "${var.real_api_ecs_cluster_name}"
  instance_type              = "${var.real_api_ecs_instance_type}"
  max_autoscaling_group_size = "${var.real_api_max_autoscaling_group_size}"
  min_autoscaling_group_size = "${var.real_api_min_autoscaling_group_size}"
  vpc_id                     = "${module.real_public_private_network.vpc_id}"
}
