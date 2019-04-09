output "deploy_user_access_key_id" {
  value = "${aws_iam_access_key.deployment.id}"
}

output "deploy_user_arn" {
  value = "${aws_iam_user.deployment.arn}"
}
output "deploy_user_secret_access_key_encrypted" {
  value = "${aws_iam_access_key.deployment.encrypted_secret}"
}
