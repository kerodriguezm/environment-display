terraform {
  backend "s3" {
    bucket  = "my-terraform-state-bucket-environment"
    encrypt = true
    key     = "infra/vpc.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}