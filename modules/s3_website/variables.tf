variable "allowed_origin_urls" {
  type        = "list"
  description = "List of origin URLS from which request"
}

variable "website_name" {
  description = "Name to use as both hostname and bucket name"
}
