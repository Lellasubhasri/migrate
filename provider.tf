provider "aws" {
    region = "eu-central-1"
    #region = "eu-west-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.1"
    }
  }
  required_version = ">= 1.0"
}

