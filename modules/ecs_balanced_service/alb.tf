resource "aws_security_group" "alb" {
  name        = "${var.service_name} ALB"
  description = "Security group for the ALB"
  vpc_id      = "${var.vpc_id}"

  tags        = {
    Name = "${var.service_name} ALB"
  }
}

resource "aws_security_group_rule" "allow_incoming_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]

  security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_security_group_rule" "allow_traffic_forward" {
  type              = "egress"
  from_port         = 32768
  to_port           = 60999
  protocol          = "tcp"
  cidr_blocks       = [
    "${var.instance_subnet_cidrs}"
  ]

  security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_alb" "alb" {
  name            = "${var.service_name}"
  security_groups = [
    "${aws_security_group.alb.id}"
  ]
  subnets         = [
    "${var.alb_subnet_ids}"
  ]

  tags {
    Name = "${var.service_name}"
  }
}

resource "aws_alb_target_group" "target_group" {
  name       = "${var.service_name}"
  port       = "${var.service_container_port}"
  protocol   = "HTTP"
  vpc_id     = "${var.vpc_id}"

  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
    interval            = "10"
    matcher             = "200"
    path                = "${var.service_health_path}"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  depends_on = [
    "aws_alb.alb"
  ]

  tags {
    Name = "${var.service_name}"
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}
