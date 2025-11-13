# backend.tf
terraform {
  backend "s3" {
    bucket  = "alta3-clearml-tfbucket" # Your new bucket name
    key     = "clearml-eks/terraform.tfstate"
    region  = "us-east-2" # <-- This MUST match your bucket's region
    encrypt = true
  }
}
