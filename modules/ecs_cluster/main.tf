resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
}

data "aws_ami" "ecs_instance" {
  most_recent = true
  owners = [
    "amazon"
  ]

  filter {
    name   = "owner-alias"
    values = [
      "amazon"
    ]
  }

  filter {
    name   = "name"
    values = [
      "amzn-ami-*-amazon-ecs-optimized"
    ]
  }
}

resource "aws_security_group" "ecs_instances" {
  name        = "${var.cluster_name} ECS instances"
  description = "Security group for each of the ECS instances"
  vpc_id      = "${var.vpc_id}"

  tags        = {
    Name = "${var.cluster_name} ECS instances"
  }
}

resource "aws_security_group_rule" "allow_forwarded_traffic" {
  type                     = "ingress"
  from_port                = 32768
  to_port                  = 60999
  protocol                 = "tcp"
  source_security_group_id = "${var.alb_security_group_id}"

  security_group_id        = "${aws_security_group.ecs_instances.id}"
}

resource "aws_security_group_rule" "allow_outgoing_https" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]

  security_group_id = "${aws_security_group.ecs_instances.id}"
}


resource "aws_launch_configuration" "ecs_instance" {
  name_prefix          = "${var.cluster_name}-"
  image_id             = "${data.aws_ami.ecs_instance.image_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.id}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups      = [
    "${aws_security_group.ecs_instances.id}"
  ]
  user_data            = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "${var.cluster_name}"
  max_size             = "${var.max_autoscaling_group_size}"
  min_size             = "${var.min_autoscaling_group_size}"
  vpc_zone_identifier  = [
    "${var.cluster_subnet_ids}"
  ]
  launch_configuration = "${aws_launch_configuration.ecs_instance.name}"
  health_check_type    = "ELB"
}
