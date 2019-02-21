output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_security_group_id" {
  value = "${aws_security_group.alb.id}"
}

output "alb_zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

output "listener_protocol" {
  value = "${aws_alb_listener.listener.protocol}"
}

output "service_name" {
  value = "${aws_ecs_service.service.name}"
}
