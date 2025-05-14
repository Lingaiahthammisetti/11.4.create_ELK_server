terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "elk-server-remote-state"
    key    = "elk_install_ec2"
    region = "us-east-1"
    dynamodb_table = "elk-server-locking"
    }
  }
provider "aws" {
  # Configuration options
  region = "us-east-1"
}