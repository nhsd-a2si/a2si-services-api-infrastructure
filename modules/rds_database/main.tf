data "aws_ssm_parameter" "password" {
  name = "${var.password_parameter}"
}

resource "aws_db_subnet_group" "subnet_group" {
  subnet_ids = [
    "${var.subnet_ids}"
  ]
}

# TODO Add encryption
resource "aws_db_instance" "db" {
  allocated_storage    = "${var.allocated_storage_gb}"
  db_subnet_group_name = "${aws_db_subnet_group.subnet_group.name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  name                 = "${var.name}"
  password             = "${data.aws_ssm_parameter.password.value}"
  storage_type         = "${var.storage_type}"
  username             = "${var.username}"
}
