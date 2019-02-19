# TODO Render the task def JSON in a template and parameterise: container name, DJANGO_HOSTNAME
# TODO Add secrets management and render in a proper DJANGO_SECRET_KEY
resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_family}"
  container_definitions = "${var.container_definitions}"
  memory                = 256
}


resource "aws_ecs_service" "service" {
  name            = "${var.service_name}"
  iam_role        = "${aws_iam_role.service_scheduler.name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = "${var.task_desired_count}"

  depends_on = [
    "aws_iam_role_policy_attachment.service_scheduler"
  ]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    container_port   = "${var.service_container_port}"
    container_name   = "${var.service_container_name}"
  }
}
