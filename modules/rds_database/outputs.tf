output "address" {
  value = "${aws_db_instance.db.address}"
}

output "db_client_security_group_id" {
  value = "${aws_security_group.db_client.id}"
}

output "db_security_group_id" {
  value = "${aws_security_group.db.id}"
}

output "port" {
  value = "${aws_db_instance.db.port}"
}
