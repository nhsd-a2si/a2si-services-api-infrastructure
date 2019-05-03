data "aws_iam_policy_document" "service_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "ecs.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "service" {
  name               = "${var.service_name}-service"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.service_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "service" {
  role       = "${aws_iam_role.service.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "task_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "task" {
  name               = "${var.service_name}-task"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.task_assume_role.json}"
}

# TODO Stop using wildcard level resource ARNs
data "aws_iam_policy_document" "task" {
  statement {
    actions   = [
      "ssm:GetParameters"
    ]

    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:*"
    ]
  }

  statement {
    actions   = [
      "kms:Decrypt"
    ]

    resources = [
      "arn:aws:kms:${var.region}:${var.account_id}:key/*"
    ]
  }
}

resource "aws_iam_policy" "task" {
  path        = "/"
  description = "IAM policy for service containers"
  policy      = "${data.aws_iam_policy_document.task.json}"
}

resource "aws_iam_role_policy_attachment" "task" {
  role       = "${aws_iam_role.task.name}"
  policy_arn = "${aws_iam_policy.task.arn}"
}
