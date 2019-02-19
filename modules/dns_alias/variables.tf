variable "alias_name" {
  description = "Fully qualified name of the alias target"
}

variable "alias_zone_id" {
  description = "ID of the hosted one in which the alias resides"
}

variable "record_name" {
  description = "Fully qualified name of the record to be inserted"
}

variable "record_zone_name" {
  description = "Name of the zone / subdomain into which the record will be inserted"
}
