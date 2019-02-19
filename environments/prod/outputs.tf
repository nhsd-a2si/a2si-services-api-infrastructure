output "real_api_service_fqdn" {
  value = "${module.real_api_service_dns_alias.record_fqdn}"
}
