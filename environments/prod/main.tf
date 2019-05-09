module "aws_account" {
  source = "../../modules/aws_account"
}

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

module "real_api_logs" {
  source            = "../../modules/cloudwatch_log_stream"
  log_group_name    = "${var.real_api_log_group_name}"
}

module "real_api_service" {
  source                        = "../../modules/ecs_balanced_service"
  alb_subnet_ids                = "${module.real_public_private_network.public_subnet_ids}"
  allow_log_policy_arn          = "${module.real_api_logs.allow_log_policy_arn}"
  account_id                    = "${module.aws_account.account_id}"
  cluster_id                    = "${module.real_api_ecs_cluster.cluster_id}"
  default_db_host               = "${module.real_api_default_db.address}"
  default_db_port               = "${module.real_api_default_db.port}"
  default_db_name               = "${var.real_api_default_db_name}"
  default_db_user               = "${var.real_api_default_db_user}"
  default_db_password_parameter = "${var.real_api_default_db_password_parameter}"
  instance_subnet_cidrs         = "${var.real_private_subnet_cidr_blocks}"
  logs_group                    = "${module.real_api_logs.log_group_name}"
  logs_stream_prefix            = "${var.real_api_logs_stream_prefix}"
  region                        = "${var.region}"
  service_container_name        = "api"
  service_container_port        = 8000
  container_definition_template = "${file("${path.module}/task_definitions/api_service.json")}"
  service_health_path           = "${var.api_service_health_path}"
  service_name                  = "${var.real_api_service_name}"
  task_desired_count            = "${var.real_api_task_desired_count}"
  task_family                   = "${var.real_api_service_name}"
  vpc_id                        = "${module.real_public_private_network.vpc_id}"
}

module "real_api_default_db" {
  source               = "../../modules/rds_database"
  allocated_storage_gb = "${var.real_api_default_db_allocated_storage_gb}"
  engine               = "${var.real_api_default_db_engine}"
  engine_version       = "${var.real_api_default_db_engine_version}"
  instance_class       = "${var.real_api_default_db_instance_class}"
  name                 = "${var.real_api_default_db_name}"
  password_parameter   = "${var.real_api_default_db_password_parameter}"
  port                 = "${var.real_api_default_db_port}"
  storage_type         = "${var.real_api_default_db_storage_type}"
  subnet_ids           = "${module.real_public_private_network.private_subnet_ids}"
  username             = "${var.real_api_default_db_user}"
  vpc_id               = "${module.real_public_private_network.vpc_id}"
}

module "real_api_ecs_cluster" {
  source                              = "../../modules/ecs_cluster"
  alb_security_group_id               = "${module.real_api_service.alb_security_group_id}"
  alb_subnet_cidrs                    = "${module.real_public_private_network.public_subnet_cidrs}"
  cluster_subnet_cidrs                = "${module.real_public_private_network.private_subnet_cidrs}"
  cluster_subnet_ids                  = "${module.real_public_private_network.private_subnet_ids}"
  cluster_name                        = "${var.real_api_ecs_cluster_name}"
  default_db_client_security_group_id = "${module.real_api_default_db.db_client_security_group_id}"
  default_db_port                     = "${module.real_api_default_db.port}"
  default_db_security_group_id        = "${module.real_api_default_db.db_security_group_id}"
  instance_type                       = "${var.real_api_ecs_instance_type}"
  max_autoscaling_group_size          = "${var.real_api_max_autoscaling_group_size}"
  min_autoscaling_group_size          = "${var.real_api_min_autoscaling_group_size}"
  vpc_id                              = "${module.real_public_private_network.vpc_id}"
}

module "real_api_service_dns_alias" {
  source           = "../../modules/dns_alias"
  alias_name       = "${module.real_api_service.alb_dns_name}"
  alias_zone_id    = "${module.real_api_service.alb_zone_id}"
  record_name      = "${var.real_api_dns_name}"
  record_zone_name = "${var.real_zone_name}"
}

module "real_api_static_website" {
  source              = "../../modules/s3_website"
  allowed_origin_urls = [
    "${lower(module.real_api_service.listener_protocol)}://${module.real_api_service_dns_alias.record_fqdn}"
  ]
  upload_user_arn     = "${module.real_deployment_user.deploy_user_arn}"
  website_name        = "${var.real_api_static_dns_name}"
}

module "real_api_static_dns_alias" {
  source           = "../../modules/dns_alias"
  alias_name       = "${module.real_api_static_website.website_domain}"
  alias_zone_id    = "${module.real_api_static_website.hosted_zone_id}"
  record_name      = "${var.real_api_static_dns_name}"
  record_zone_name = "${var.real_zone_name}"
}

module "real_deployment_user" {
  source           = "../../modules/deployment_user"
  ecs_cluster_arn  = "${module.real_api_ecs_cluster.cluster_arn}"
  network_name     = "${var.real_network_name}"
  operator_pgp_key = "${var.operator_pgp_key}"
}
