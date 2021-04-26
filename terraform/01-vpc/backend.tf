terraform {
  backend "s3" {
    bucket = "terraform-s3-backend"
    key    = "vpc.tfstate"
    region = "us-east-2"
  }
}