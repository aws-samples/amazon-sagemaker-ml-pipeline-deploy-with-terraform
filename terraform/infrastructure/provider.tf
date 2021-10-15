terraform {
  required_version = ">= 0.13.5"
}

provider "aws" {
  region = var.region
}