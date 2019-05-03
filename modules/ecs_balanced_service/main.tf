data "template_file" "task" {
  template = "${var.container_definition_template}"

  vars {
    account_id                    = "${var.account_id}",
    default_db_host               = "${var.default_db_host}"
    default_db_port               = "${var.default_db_port}"
    default_db_name               = "${var.default_db_name}"
    default_db_password_parameter = "${var.default_db_password_parameter}"
    default_db_user               = "${var.default_db_user}"
    region                        = "${var.region}"
  }
}

# TODO Pass in container name, DJANGO_HOSTNAME, and a proper DJANGO_SECRET_KEY
resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_family}"
  container_definitions = "${data.template_file.task.rendered}"
  execution_role_arn    = "${aws_iam_role.task.arn}"
  memory                = 256
}

data "aws_ecs_task_definition" "task" {
  task_definition = "${aws_ecs_task_definition.task.family}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.service_name}"
  iam_role        = "${aws_iam_role.service.name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.task.family}:${max("${aws_ecs_task_definition.task.revision}", "${data.aws_ecs_task_definition.task.revision}")}"

  desired_count   = "${var.task_desired_count}"

  depends_on      = [
    "aws_iam_role_policy_attachment.service",
    "aws_iam_role_policy_attachment.task"
  ]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    container_port   = "${var.service_container_port}"
    container_name   = "${var.service_container_name}"
  }
}
