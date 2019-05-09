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
  allocated_storage      = "${var.allocated_storage_gb}"
  db_subnet_group_name   = "${aws_db_subnet_group.subnet_group.name}"
  engine                 = "${var.engine}"
  engine_version         = "${var.engine_version}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.name}"
  password               = "${data.aws_ssm_parameter.password.value}"
  storage_type           = "${var.storage_type}"
  username               = "${var.username}"
  vpc_security_group_ids = [
    "${aws_security_group.db.id}"
  ]
}

resource "aws_security_group" "db" {
  description = "Allow connection by appointed dataabase clients"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_db_client" {
  type                     = "ingress"
  from_port                = "${var.port}"
  to_port                  = "${var.port}"
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.db_client.id}"

  security_group_id        = "${aws_security_group.db.id}"
}

resource "aws_security_group" "db_client" {
  description = "Entities added to this group will be database clients"
  vpc_id      = "${var.vpc_id}"
}
