variable "zone_id" {
  default     = null
  description = "The ID of the private hosted zone, in this (the zone-owning) account, to authorize an association for."
}

variable "vpc_id" {
  default     = null
  description = "The ID of the VPC, in the other account, to authorize."
}

variable "vpc_region" {
  default     = null
  description = "Region of the VPC to authorize. If null, assumed to be in the same region as this provider."
}
