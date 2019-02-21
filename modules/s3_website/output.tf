output "hosted_zone_id" {
  value = "${aws_s3_bucket.website.hosted_zone_id}"
}

output "website_domain" {
  value = "${aws_s3_bucket.website.website_domain}"
}
