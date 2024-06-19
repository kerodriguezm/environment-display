variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "log_group" {
  default = "/ecs/develop"
}

variable "image" {
  default = "556332166226.dkr.ecr.us-east-1.amazonaws.com/develop:latest"
}