output "deploy_user_secret_access_key_encrypted" {
  value = "${module.real_api_ecs_deployment_user.deploy_user_secret_access_key_encrypted}"
}

output "real_api_service_fqdn" {
  value = "${module.real_api_service_dns_alias.record_fqdn}"
}

output "real_api_cluster" {
  value = "${module.real_api_ecs_cluster.cluster_name}"
}

output "real_api_deploy_user_access_key_id" {
  value = "${module.real_api_ecs_deployment_user.deploy_user_access_key_id}"
}

output "real_api_service_name" {
  value = "${module.real_api_service.service_name}"
}
