# TODO Find a way to limit the scope of this policy so as not to include all of ECS
resource "aws_iam_policy" "deployment" {
  name        = "${var.network_name}-deployment"
  description = "Allow deployment actions on ${var.network_name}"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:DescribeServices",
        "ecs:DescribeTaskDefinition",
        "ecs:DescribeTasks",
        "ecs:ListClusters",
        "ecs:ListServices",
        "ecs:ListTasks",
        "ecs:RegisterTaskDefinition",
        "ecs:UpdateService",
        "iam:PassRole"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "deployment" {
  name = "${var.network_name}-deployment"
}

resource "aws_iam_access_key" "deployment" {
  user    = "${aws_iam_user.deployment.name}"
  pgp_key = "${var.operator_pgp_key}"
}

resource "aws_iam_user_policy_attachment" "deployment" {
  user       = "${aws_iam_user.deployment.name}"
  policy_arn = "${aws_iam_policy.deployment.arn}"
}
