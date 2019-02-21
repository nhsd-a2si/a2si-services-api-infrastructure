resource "aws_s3_bucket" "website" {
  bucket = "${var.website_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = [
      "*"
    ]
    allowed_methods = [
      "GET"
    ]
    allowed_origins = [
      "${var.allowed_origin_urls}"
    ]
    expose_headers  = [
      "ETag"
    ]
    max_age_seconds = 3000
  }
}
