# backend.tf
terraform {
  backend "s3" {
    bucket  = "alta3-spizz-clearml-tftstate"
    key     = "clearml-eks/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}