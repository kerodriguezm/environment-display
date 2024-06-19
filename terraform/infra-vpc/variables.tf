variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone_a"{
  description = "AWS availability zones"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_b"{
  description = "AWS availability zones"
  type        = string
  default     = "us-east-1b"
}
