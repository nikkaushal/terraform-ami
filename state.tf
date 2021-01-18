terraform {
  backend "s3" {
    bucket          = "nik-terraform-state-files"
    key             = "ami/dev/terraform.tfstate"
    region          = "us-east-1"
    dynamodb_table  = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
}