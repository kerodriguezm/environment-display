variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "log_group" {
  default = "/ecs/develop"
}
