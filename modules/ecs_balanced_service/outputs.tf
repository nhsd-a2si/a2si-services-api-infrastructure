output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_security_group_id" {
  value = "${aws_security_group.alb.id}"
}

output "alb_zone_id" {
  value = "${aws_alb.alb.zone_id}"
}
