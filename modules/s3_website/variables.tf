variable "allowed_origin_urls" {
  type        = "list"
  description = "List of origin URLS from which request"
}

variable "upload_user_arn" {
  description = "ARN of the user who will be granted upload access"
}

variable "website_name" {
  description = "Name to use as both hostname and bucket name"
}
