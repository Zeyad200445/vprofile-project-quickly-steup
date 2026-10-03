terraform {
  backend "s3" {
    bucket         = "terraforms-states-bucketss"
    key            = "vpc-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
  }
}