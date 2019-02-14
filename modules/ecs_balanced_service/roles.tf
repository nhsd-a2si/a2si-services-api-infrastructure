data "aws_iam_policy_document" "service_scheduler" {
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

resource "aws_iam_role" "service_scheduler" {
  name               = "${var.service_name}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.service_scheduler.json}"
}

resource "aws_iam_role_policy_attachment" "service_scheduler" {
  role       = "${aws_iam_role.service_scheduler.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
