resource "aws_cloudwatch_log_group" "log" {
  name = "${var.log_group_name}"
}

resource "aws_iam_policy" "allow_log" {
  name        = "allow_${var.log_group_name}"
  path        = "/"
  description = "Allow streaming to the ${var.log_group_name} log group"

  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "${aws_cloudwatch_log_group.log.arn}"
    }
  ]
}
EOF
}

