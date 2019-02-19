resource "aws_iam_policy" "ecs_deployment" {
  name        = "${var.ecs_cluster_name}-deploy"
  description = "Allow ECS deployment actions on ${var.ecs_cluster_name} cluster"
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
        "ecs:UpdateService"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "ecs_deployment" {
  name = "${var.ecs_cluster_name}-deploy"
}

resource "aws_iam_access_key" "ecs_deployment" {
  user    = "${aws_iam_user.ecs_deployment.name}"
  pgp_key = "${var.operator_pgp_key}"
}

resource "aws_iam_user_policy_attachment" "ecs_deployment" {
  user       = "${aws_iam_user.ecs_deployment.name}"
  policy_arn = "${aws_iam_policy.ecs_deployment.arn}"
}
