output "allow_log_policy_arn" {
  value = "${aws_iam_policy.allow_log.arn}"
}

output "log_group_name" {
  value = "${aws_cloudwatch_log_group.log.name}"
}
