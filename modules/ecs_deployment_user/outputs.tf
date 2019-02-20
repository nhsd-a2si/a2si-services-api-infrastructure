output "deploy_user_access_key_id" {
  value = "${aws_iam_access_key.ecs_deployment.id}"
}

output "deploy_user_secret_access_key_encrypted" {
  value = "${aws_iam_access_key.ecs_deployment.encrypted_secret}"
}
